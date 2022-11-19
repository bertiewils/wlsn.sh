---
title: "Restoring Unsupported DB Engine Snapshots on AWS RDS"
date: 2022-09-19T15:37:55+01:00
draft: false
author: Bertie
description: How to restore an old DB snapshot
categories:
- Cloud
tags:
- AWS
- RDS
---

Amazon's Relational Database Service (RDS) makes creating and maintaining databases extremely easy.
Interestingly, they link instance types with database engine verisons, so only certain engine versions can run on certain instance types.

When trying to restore a snapshot from an old PostgreSQL 9.5.x database I found the AWS web interface didn't give the option to choose a `db.t2.x` instance, which is the last instance class that supports PSQL 9.5, despite the option being there if creating a fresh instance. Trying to restore to a `db.t3.x` instance gave the following error:

> :exclamation: RDS does not support creating a DB instance with the following combination:
`DBInstanceClass=db.t3.medium, Engine=postgres, EngineVersion=9.5.24,  LicenseModel=postgresql-license.` For supported combinations of instance class and database engine version, see the documentation.

Said documentation can be found [here](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html#Concepts.DBInstanceClass.Support).

Despite lots of searching, it took paying for AWS Support to find out it will work using the AWS CLI, even if the option isn't available in the web interface.

The following worked perfectly when setting the instance class to `db.t2.medium`:

```shell
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier <newdbidentifier> \
  --db-snapshot-identifier <snapshotidentifier> \
  --db-instance-class <newinstanceclass> \
  --region <snapshot-region>
```
