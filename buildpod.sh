PROJECT_NAME=${PWD##*/}

pushd "$(dirname "$0")" > /dev/null
SCRIPT_DIR=$(pwd -L)
popd > /dev/null

git config --get user.name
git config --get user.email

echo "publish repo $PROJECT_NAME"
pod repo push tzyk-pod-specs $PROJECT_NAME.podspec --verbose --allow-warnings --skip-tests --skip-import-validation --swift-version=5

ret=$?

if [ "$ret" -ne "0" ];then
	exit 1
fi
