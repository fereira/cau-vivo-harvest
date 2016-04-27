#!/bin/sh
php import_csv.php
php fetch.php
#php sanitize-fetchdata.php
php translate.php
php transfer.php
#php score.php
#php truncate.php
#php match.php
#php changenamespace.php
#php diff.php
#php applyprevious.php
#php finaltransfer.php

