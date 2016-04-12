
Proposal 1
==========

Have the `meal` record that gets used to populate the meal form be backed by a Backbone model
and have it do the necessary massaging of the data before sending it to the client.

1) meal model
2) bill model
x 3) bill collection
4) meal_resident model
5) meal_residents collection
6) guest model
7) guest collection


Bill Scenarios (on Load)
==============

1) Name Blank, Cost Blank
    - actions
        a) Name Added
        b) Cost changed to invalid amount
        c) Cost changed to valid amount
2) Name Present, Cost Blank
    - actions
        a) Name Changed to another name
        b) Name Changed to blank
        c) Cost changed to valid amount
        d) Cost changed to invalid amount
3) Name Blank, Cost Present - invalid
4) Name Present, Cost Present
    - actions
        a) Name Changed to another name
        b) Name Changed to blank
        c) Cost changed to valid amount
        d) Cost Changed to invalid amount

1a) Create bill
1b) Do nothing
1c) Do nothing

2a) Update bill
2b) Destroy bill
2c) Update bill
2d) ??? - notify client, don't update

4a) Update bill
4b) Destroy bill
4c) Update bill
4d) ??? - notify client, don't update

On page load - create backbone models out of data





Proposal 2
==========

Make page into 1 giant form








Components
==========

date box
========
{
  date: Date,
  status: one_of[OPEN, RECONCILED, CLOSED]
}


menu
====
{
  menu: String
}

cooks
=====
