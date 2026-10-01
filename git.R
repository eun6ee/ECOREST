install.packages(c("usethis", "gitcreds"))
library("gitcreds")
# 1. 발급페이지가브라우저에열림
usethis::create_github_token()
#   Note 칸에용도를적음(예: ecoland-2026)
#   Expiration 은90 days 정도
#   scope 는repo, workflow, user 가체크된상태로둘것

# 2. 생성된ghp_ 로시작하는문자열을복사한뒤
gitcreds::gitcreds_set()
#   콘솔이물어보면붙여넣고엔터