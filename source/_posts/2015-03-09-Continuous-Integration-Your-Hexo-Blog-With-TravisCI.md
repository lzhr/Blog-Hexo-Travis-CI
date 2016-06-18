---
title: Continuous Integration Your Hexo Blog With Travis CI
date: 2015-03-09 09:47:20
categories: 技术
tags: Javascript
author: Bigruan
keywords: 转载
---

Everything works fine after migrating my blog to [hexo](http://hexo.io), it's just not cool that everytime I have to run *hexo deploy* to publish my posts.
Cool boy uses Travis-CI, right?

### Step 1 - generate a personal access token at Github

Go to https://github.com/settings/applications#personal-access-tokens and Generate new token

### Step 2 - add an environment variable to your Travis-CI project.

<!-- more -->

1. Go to project Settings and choose Environment Variables
2. Variable Name: DEPLOY_REPO
3. Variable Value: https://{github_access_token}@github.com/{github_username}/{repository_name}.git (for example: https://8260b82839xx2d19387a51bafca4d5425da7@github.com/ruanyl/ruanyl.github.io.git)

### Step 3 - edit .travis.yml file

```bash
language: node_js
node_js:
    - "0.12"

before_install:
    - npm install -g hexo

install:
    - npm install

before_script:
    - git config --global user.name 'ruanyl'
    - git config --global user.email 'ruanyu1@gmail.com'

script:
    - hexo generate

after_success:
    - mkdir .deploy
    - cd .deploy
    - git init
    - git remote add origin $DEPLOY_REPO
    - cp -r ../public/* .
    - git add -A .
    - git commit -m 'Site updated'
    - git push --force --quiet origin master
```

### Notice! If you have 3rd party themes installed
You have to add the theme repo as a gitmodule, add a file named: .gitmodules under the root dir of your hexo blog and add:

```bash
[submodule "alex"]
    path = themes/alex
    url = https://github.com/ruanyl/hexo-theme-alex.git
```

### 转载自 [Bigruan](http://blog.bigruan.com/2015-03-09-Continuous-Integration-Your-Hexo-Blog-With-TravisCI/)
