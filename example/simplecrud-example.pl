#!/usr/bin/perl

use lib '../lib';
use Dancer;
use Dancer::Plugin::SimpleCRUD;

simple_crud(
    record_title => 'Person',
    db_table => 'people',
    prefix => '/people',
    acceptable_values => {
        gender => [ qw( Male Female ) ],
    },
    deletable => 'yes',
    sortable => 'yes',
    paginate => 5,
    downloadable => 1,
    foreign_keys => {
        employer_id => {
            table        => 'employer',
            key_column   => 'id',
            label_column => 'name',
        },
    },
    custom_columns => {
        mailto_link => {
            raw_column => 'email',
            transform  => sub { my $email = shift; return "<a href='mailto:$email'>mail</a>"; },
        },
        full_name => {
            raw_column => "(first_name || ' ' || last_name)",
            transform => sub { return shift }, # (unnecessary, btw, as this is the default)
        },
    },
);

get '/' => sub {
    redirect '/people';
};


dance;
