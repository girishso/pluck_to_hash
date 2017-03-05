# 1.0 - 2016-06-10 

* Hash keys are now strings instead of symbols to match behavior with `HashWithIndifferentAccess` [[#15](https://github.com/girishso/pluck_to_hash/pull/15)] @MrEmelianenko
* Now accepts a block, which will return an array of whatever the block returns [[#15](https://github.com/girishso/pluck_to_hash/pull/15#issue-157198216)] @MrEmelianenko
* Hash and Struct return types can be overridden (defaults are `HashWithIndifferentAccess`/`Struct`) [[#16](https://github.com/girishso/pluck_to_hash/pull/16)] @offthecuff
