// Googleスプレッドシートのスクリプトエディタ上で実行してください。

// Excelデータ取得先のURL
var EXCEL_URL = "http://www.mext.go.jp/component/a_menu/science/detail/__icsFiles/afieldfile/2016/03/24/1365334_1r7.xlsx"

// アップロード先フォルダ(idをrootフォルダから順に指定)
var DEST_FOLDERS = [
  "(id_0)",
  "(id_1)"
];

// 取得したい栄養素
var NUT_ARRAY = [
"エネルギー（kcal）",
"たんぱく質",
"脂   質",
"飽和脂肪酸",
"一価不飽和脂肪酸",
"多価不飽和脂肪酸",
"コレステロール",
"炭水化物",
"水溶性食物繊維",
"食物繊維総量",
"ナトリウム",
"カリウム",
"カルシウム",
"マグネシウム",
"鉄",
"亜鉛",
"銅",
"マンガン",
"ヨウ素",
"セレン",
"クロム",
"モリブデン",
"レチノール活性当量",
"ビタミンD",
"α-トコフェロール",
"ビタミンK",
"ビタミンB1",
"ビタミンB2",
"ナイアシン",
"ビタミンB6",
"ビタミンB12",
"葉酸",
"パントテン酸",
"ビオチン",
"ビタミンC"
];

// 実データ領域の開始行、開始列
var DATA_ROW = 6;
var DATA_COL = 6;

// 削除する行ヘッダの行数
var DEL_ROWS = 8;

// 削除する列ヘッダ
var DEL_COLUMNS = [
//1, // 食品群
  2, // 食品番号
  3, // 索引番号
//4, // 食品名
  5  // 廃棄率
];

function onOpen(){
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var menu = [
    {name: "CSV出力", functionName: "getInitFoodsCSV"}
  ];
  ss.addMenu("カスタム関数", menu);
}

function getInitFoodsCSV() {
  // 文科省の日本食品標準成分表をスプレッドシート形式で取得
  var ss = getSpreadsheetFromMext(EXCEL_URL, "initFoods", "initFoods");
  var sheet = ss.getActiveSheet();

  // 並び替え
  sortSheet(sheet);

  // 不要な部分をカット
  shapeSheet(sheet);

  // '(', ')', 'Tr', '-'を置換
  replaceValues(sheet);

  // CSVを出力
  convertSheetToCSV(sheet, "initFoods.csv");
}

function getSpreadsheetFromMext(url, ssName, sheetName) {
  var blob = UrlFetchApp.fetch(url).getBlob();
  var ss = convertExcelToSpreadsheet(blob, ssName, DEST_FOLDERS);
  var sheet = ss.getActiveSheet();
  sheet.copyTo(ss);
  sheet.setName(sheetName);
  return ss;
}

function convertExcelToSpreadsheet(excelFile, filename, arrParents) {
  var parents = arrParents || [];

  var uploadParams = {
    method: 'post',
    contentType: 'application/vnd.ms-excel',
    contentLength: excelFile.getBytes().length,
    headers: {'Authorization': 'Bearer ' + ScriptApp.getOAuthToken()},
    payload: excelFile.getBytes(),
  };

  try{
    var uploadResponse = UrlFetchApp.fetch('https://www.googleapis.com/upload/drive/v2/files/?uploadType=media&convert=true', uploadParams);
  }
  catch(e){
    Logger.log(e.message+"\n"+e.fileName+"\n"+e.lineNumber+"\n"+e.stack);
  }

  var fileDataResponse = JSON.parse(uploadResponse.getContentText());

  var payloadData = {
    title: filename,
    parents: []
  };

  if (parents.length) {
    for (var i=0; i<parents.length; i++) {
      try {
        var folder = DriveApp.getFolderById(parents[i]);
        payloadData.parents.push({id: parents[i]});
      }
      catch(e){
        Logger.log(e.message+"\n"+e.fileName+"\n"+e.lineNumber+"\n"+e.stack);
      }
    }
  }

  var updateParams = {
    method: 'put',
    headers: {'Authorization': 'Bearer ' + ScriptApp.getOAuthToken()},
    contentType: 'application/json',
    payload: JSON.stringify(payloadData)
  };

  try{
    UrlFetchApp.fetch('https://www.googleapis.com/drive/v2/files/'+fileDataResponse.id, updateParams);
  }
  catch(e){
    Logger.log(e.message+"\n"+e.fileName+"\n"+e.lineNumber+"\n"+e.stack);
  }

  return SpreadsheetApp.openById(fileDataResponse.id);
}

function sortSheet(sheet){
  var maxColumns = sheet.getMaxColumns();
  var maxRows = sheet.getMaxRows();

  var nutValues = sheet.getRange(DATA_ROW, DATA_COL, 1, maxColumns -  (DATA_COL -1)).getValues()[0];
  var i = 0;
  var j = 0;
  var fromRange;
  var toRange;
  while(true){
    if(nutValues[j] === NUT_ARRAY[i]){
      // コピー処理
      var to = DATA_COL + i;
      var from = DATA_COL + j;
      sheet.insertColumns(to, 1);
      from++;
      fromRange = sheet.getRange(1, from, maxRows);
      toRange = sheet.getRange(1, to, maxRows);
      fromRange.copyTo(toRange, {contentsOnly:true});
      sheet.deleteColumn(from);

      i++;
      j = i;
    } else {
      j++;
    }
    // 末尾までソートできたら、ループを抜ける
    if(i === NUT_ARRAY.length) break;
  }
}

function shapeSheet(sheet) {
  // A1が空白なら、未加工とみなす
  if( sheet.getRange("A1").getValue() === ""){
    // 不要な列を消す
    var delColStart = DATA_COL + NUT_ARRAY.length;
    sheet.deleteColumns(delColStart, sheet.getMaxColumns() - (delColStart - 1));

    // 指定された列ヘッダを削除
    for( var i = DEL_COLUMNS.length - 1; i >= 0; i-- ) {
      sheet.deleteColumn(DEL_COLUMNS[i]);
    }

    // 指定された行ヘッダを削除
    sheet.deleteRows(1, DEL_ROWS);

    // 末尾に空白行がある場合は、空白行を削除
    if(sheet.getRange(sheet.getMaxRows(), 1) === ""){
      var d = 100;
      var stepArr = [100, 10, 1];
      var search = function(index){
        var v = "v";

        // stepごとに空白チェック
        for ( ; v !== ""; d += stepArr[index]) {
          v = sheet.getRange(d, 1).getValue();
        }
        // 進み過ぎたdを戻す
        if( index !== stepArr.length - 1 ){
          d -= stepArr[index] * 2 - stepArr[index + 1];
        }
      }
      // 削除実行
      for ( var index = 0; index < stepArr.length; index++ ){
        search(index);
      }
      sheet.deleteRows(d - 1, sheet.getMaxRows() - (d - 2));
    }
  }
}

function replaceValues(sheet){
  var maxRow = sheet.getMaxRows();
  var maxColumn = sheet.getMaxColumns();
  var height = maxRow;
  var width = maxColumn - 2;

  // 列ヘッダを除いたRangeのValuesを取得
  var values = sheet.getRange(1, 3, height, width).getValues();
  var value;
  // Range内のr行c列に対して置換
  for(var r = 0; r < height; r++){
    for(var c = 0; c < width; c++){
      value = values[r][c].toString().trim();
      switch(value.substr(0, 1)){
        case '(':
          value = value.replace(/[()]/g, '');
          value = value.replace(/Tr/, '0');
          sheet.getRange(r + 1, c + 3).setValue(value);
          break;
        case '-':
        case 'T':
          value = value.replace(/-|Tr/, '0');
          sheet.getRange(r + 1, c + 3).setValue(value);
          break;
        default:
          break;
      }
    }
  }
}

function convertSheetToCSV(sheet, filename) {
  // 二次元配列を取得
  var values = sheet.getDataRange().getValues();

  // 繰り返し処理で、CSV形式の文字列を生成
  var csvString = underscoreGS._map(
    values,
    function(row){
      return row.join(",");
    }
  ).join("\n");
  csvString += "\n";

  // blob化し、ファイル出力
  var blob = Utilities.newBlob("", "text/csv", filename).setDataFromString(csvString, "UTF8");
  var dir = DriveApp.getFolderById(DEST_FOLDERS[DEST_FOLDERS.length - 1]);
  dir.createFile(blob);
}
