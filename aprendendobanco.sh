#!/bin/bash
inputfile="test.txt"
cat $inputfile | while read ip mac server; do
    echo "INSERT INTO test (IP,MAC,SERVER) VALUES ('$ip', '$mac', '$server');"
done | mysql -uroot -ptest test;
