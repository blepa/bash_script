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

#merge files
git merge-file 1.0.24.4/MAIN_SEQ.sh dummy edp2439/MAIN_SEQ.sh

##package_create.sh
#!/bin/bash

# properties file
GIT_PROP_FILE=./config/git.prop

# delare error
E_DID_NOTHING=1
# declare error print
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

# check is git installed
if ! [ -x "$(command -v git)" ]; then
  err 'Error: git is not installed.' >&2
  exit "${E_DID_NOTHING}"
fi

# declare input constants with default value
BASE_BRANCH=
CURRENT_BRANCH=
DIFF_FILTER=



# properties
GIT_PROP_FILE=

get_property() {
    grep "${2}" ${1}|cut -d'=' -f2
}

# parse input
while getopts ab:c-: arg; do
  case $arg in
    a )  ARG_A=true ;;
    b )  ARG_B="$OPTARG" ;;
    c )  ARG_C=true ;;
    - )  LONG_OPTARG="${OPTARG#*=}"
         case $OPTARG in
           base_branch=?* ) BASE_BRANCH="$LONG_OPTARG" ;;
           base_branch* ) echo "No arg for --$OPTARG option" >&2; exit 2 ;;
           current_branch=?* ) BASE_BRANCH="$LONG_OPTARG" ;;
           current_branch* ) echo "No arg for --$OPTARG option" >&2; exit 2 ;;           
           diff_filter=?* ) DIFF_FILTER="$LONG_OPTARG" ;;
           diff_filter*   )  echo "No arg for --$OPTARG option" >&2; exit 2 ;;
           git_prop_file=?* ) DIFF_FILTER="$LONG_OPTARG" ;;
           git_prop_file*   )  echo "No arg for --$OPTARG option" >&2; exit 2 ;;
           '' )        break ;; # "--" terminates argument processing
           * )         echo "Illegal option --$OPTARG" >&2; exit 2 ;;
         esac ;;
    \? ) exit 2 ;;  # getopts already reported the illegal option
  esac
done
shift $((OPTIND-1)) # remove parsed options and args from $@ list

# Get parent branch
#get_parent_branch() {
#    case "$1" in
#        feature
#
#    esac
#}

# Set defualt value
if [ -z $GIT_PROP_FILE]; then GIT_PROP_FILE=./config/git.properties
fi
if [ -z $DIFF_FILTER ]; then DIFF_FILTER=d 
fi
if [ -z $CURRENT_BRANCH]; then CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi


echo $DIFF_FILTER
echo $BASE_BRANCH
echo $CURRENT_BRANCH


echo "birthday" | cut -d'/' -f 1

get_branch_type() {
  $1 | sed 's/:.*//'
}



file="./config/git.properites"


prop() {
    grep "${1}" ./config/git.properties|cut -d'=' -f2
}

echo $(prop "parent.brnach.hotfix=master")
echo $(get_property "./config/git.properties" "parent.brnach.hotfix=master")


FRED="/some/random/file.csv:some string"
a=${FRED%:*}
echo $a

PATH=feture
ROOT=${PATH#/} ROOT=/${ROOT%%/*}

echo ${PATH#/}
echo ${PATH%'/'*}

##git.properties
base_branch.feature=develop
base.branch.bugfix=develop
base.branch.release=master
base.branch.hotfix=master
