## PG Extras Stat Collector

A simple project that collects usage information from the [pg-extras plugin][1]. The project consists of two parts, additions to the pg-extras plugin to send usage data, and a simple Sinatra app to receive it.

The Sinatra app receives a single `POST` containing a string representing the command ran. This is inserted into a database along with a timestamp and we can use [Dataclips][2] to analyze / publish later.

The CLI plugin is extended to do two things; prompt for opt in/out of collection, and sending the `POST`. After installing/upgrading the plugin, the user is prompted to opt in/out of the collection with a simple `y|n` option (default `y`). Both options set a config file in the existing `~/.heroku/` folder, with a setting `opt-in:true|false` value. 

For every command ran in the plugin, a background thread will check the this config file and the value in it. If `yes`, the command is posted to the Sinatra app. A thread is used to help ensure this process doesn't interfere with normal usage. The plugin does not wait for or ensure the `POST` completes. 







[1]: https://github.com/heroku/heroku-pg-extras 
[2]: https://dataclips.heroku.com