# Registration Processor Test Packet Uploader 

## Prerequisites

* The scripts here require `python3` that must have got installed during the standard deployment setup.

## Auth partner onboarding
IDA has to be onboarded as partner. Execute the partner onboarding scripts [here](../../utils/onboard/partner/). 

## Packet creation

Refer to notes in `config.py` and `data/packet*/ptkconf.py` for various parameters of a packet.  Parameters here must match records in Master DB.

Following example packets are provided.  All these are for new registration.
1. `packet1`: Individual 1 biometrics, no operator biometrics.
1. `packet2`: Individual 2 biometrics different from above, no operator biometrics
1. `packet2`: Indiviual 2 biometrics with operator biometrics of Individual 1. 

You also need to edit `tests/regproc/config.py` file to point to your sandbox instead of the default `https://minibox.mosip.net`. 

## Clearing the DB
Note that the default username and password for postgres is 'postgres' and 'mosip123' respectively.

This is optional.  To see your packet clearly, you may want to clear all records of previous packets in `mosip_regprc` tables:

```
$ ./cleardb.sh
```
Provide your postgres password.

## Upload registration packet

```
$ ./test_regproc.py
```

## Verify


1. Verify the transactions as below:
    ```
    $ ./checkdb.sh
    Provide postgres password.  Note that it may take several seconds for packet to go through all the stages.  You must see a `SUCCESS` for all stages. 
    ```
1. UIN should have got generated.
1. The latest transaction must be seen in  `credential_transaction` table of `mosip_credential` DB.
1. Further, `identity_cache` table of `mosip_ida` db should have fresh entries corresponding to the timestamp of UIN generated. 

_Some useful postgres commands_:
- Data is held in _databases_, which have subunits of data called _tables_
- To connect: `psql -h mzworker0.sb -p 30090 -U postgres`
- to list databases: `\l`
- connect to a database: `\c <db>`
- show database: `SELECT current_database();`
- list tables in current db: `\dt`
- show table: `SELECT * FROM <table>;`
- disconnect: `\q`.
