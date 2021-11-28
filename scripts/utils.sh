# Converts the given string to lowercase using
# awk
# @param string to convert to lowercase
tolower() {
  echo $(echo $1 | awk '{print tolower($0)}')
}
