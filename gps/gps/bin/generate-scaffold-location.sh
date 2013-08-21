#!/bin/sh

# rails generate scaffold location user_id:integer weight:decimal reading_time:datetime clothing_wt:decimal
rails generate scaffold location time:datetime lat:decimal lon:decimal
