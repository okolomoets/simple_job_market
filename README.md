# Simple Job Market

## Description

This is an implementation of the simple job market that was done as a test task. 
More details about the app requirements may be found [here](https://docs.google.com/document/d/17wv7TI5TJiOj6NRAOdkMutHJ_Lthr17msjm-AqT-yRw/edit)

## Quick setup;

Install the Ruby version 3.3.0. I prefer to use `asdf` for this, but you may use any other tools:

```bash
asdf local ruby 3.3.0
```

Install gems: 

```bash
bundle install
```

Setup DB:

```bash
rake db:create && rake db:migrate && rake db:seed
```

Start the application: 

```bash
rails s
```

That's it

## Use cases

1. Get `Jobs` list

You can make a request to `/api/v1/jobs` path. This endpoint will return you all the jobs in the system(`activated`, `deactivated`) by default.

You can also use `status` param to filter the jobs by the job's status. Supported statuses: `activated`, `deactivated`

2. Get `Applications` list

You can make a request to `/api/v1/applications` path. This endpoint will return you all the applications for `activated` jobs by default.

You can also use `status` param to filter the applications by the job's status. Supported statuses: `activated`, `deactivated`






