function submitWithValue(formId, value) {
  var form = document.getElementById(formId);
  var commit = document.getElementById("form_commit_value");
  commit.value = value;
  form.submit();
}
