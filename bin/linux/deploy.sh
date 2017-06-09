#!/usr/bin/env bash

echo Running DMIS App Deploy, current branch is $BRANCH
echo Target Branch is $BASE_BRANCH
echo Head Branch is $HEAD_BRANCH
echo Is Pull Request is $IS_PULL_REQUEST

# We don't want to deploy Pull Requests only builds on develop and master
if [ $IS_PULL_REQUEST == true ]
    then
        echo Not Deploying Build $BUILD_NUMBER - Branch is $BRANCH, Is Pull Request is $IS_PULL_REQUEST
        return
fi

# Set Version Number
VERSION=v.0.0.$BUILD_NUMBER-$BRANCH

# Only deploy to Staging if we're on develop and testing the Staging Environment
if [ $BRANCH == "develop" ]
    then
        pip install --upgrade pip
        pip install -r requirements.txt

        # TODO - establish way of securing credentials
        #export AWS_CREDENTIAL_FILE=./.ebextensions/eb.credentials

        # Set appropriate environment var
        mv ./.ebextensions/environment.staging ./.ebextensions/environment.config
        printf '1\nn\n' | eb init dmis --region eu-west-1

        # Uncomment if debug needed
        # tail ./.elasticbeanstalk/config.yml
        # tail ./.ebextensions/environment.config

        # Deploy develop builds to Staging environment
        echo Deploying $VERSION to dmis-staging
        eb use dmis-staging
        eb deploy -l $VERSION

fi

# Only deploy to Prod if we're on master and testing the Prod Environment
if [ $BRANCH == "master" ]
    then
        pip install --upgrade pip
        pip install -r requirements.txt

        # TODO - establish way of securing credentials
        # export AWS_CREDENTIAL_FILE=./.ebextensions/eb.credentials

        # Set appropriate environment var
        mv ./.ebextensions/environment.prod ./.ebextensions/environment.config
        printf '1\nn\n' | eb init dmis --region eu-west-1

        # Uncomment if debug needed
        # tail ./.elasticbeanstalk/config.yml
        # tail ./.ebextensions/environment.config

        # Deploy master builds to Prod environment
        echo Deploying $VERSION to dmis-prod
        eb use dmis-prod
        eb deploy -l $VERSION

        # Tag Prod version
        git tag -a $VERSION -m "$VERSION deployed to $DMIS_ENV "
        git push origin $VERSION

        # Sleep 50s after deploy to allow AWS to stabalise prior to running integration tests
        #echo "Sleeping to let AWS Stabalise..."
        #sleep 50s
fi
