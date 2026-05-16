alias salam='cowsay Bah, salam ali agha'
alias pvim='proxychains -q vim'
alias jalali_time='read y m d <<< $(curl -sL https://api.time.ir/v1/time/fa/time/now -H "x-api-key:ZAVdqwuySASubByCed5KYuYMzb9uB2f7" | jq -r ".data.jalali | \"\(.year) \(.month) \(.day)\""); time_now=$(TZ="Asia/Tehran" date +"%H:%M:%S"); printf "%04d-%02d-%02d %s\n" "$y" "$m" "$d" "$time_now"'
alias tmux='tmux -u'
