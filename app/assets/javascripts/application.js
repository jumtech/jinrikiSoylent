function submitWithValue(formId, value) {
  var form = document.getElementById(formId);
  var commit = document.getElementById("commit_value");
  commit.value = value;
  form.submit();
}
