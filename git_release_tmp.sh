#base commit in branch:
diff -u <(git rev-list --first-parent feature/b003) \
             <(git rev-list --first-parent develop) | \
     sed -ne 's/^ //p' | head -1
#one line:
diff -u <(git rev-list --first-parent feature/b003 --) <(git rev-list --first-parent develop --) | sed -ne 's/^ //p' | head -1	 
	 
git diff --name-only develop..feature/EDP-2423 --diff-filter=d

git archive --format=zip HEAD `git diff feature/EDP-2423..develop --name-only` > a.zip

#get list commit
git log --pretty=format:'%H' -n 1

#get commit count across all branches
git rev-list --all --count
