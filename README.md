# mysql-vagrant

mysql-vagrant is a quick way to run mysql locally for development without an ssh tunnel

This box loads a bunch of Medicaid data from [Here](https://data.medicare.gov/data/hospital-compare), mostly regarding hospital comparisons.  This data was chosen because I could make it relational, it was easy to find...and the person I'm teaching knows a lot more about it than me.

You can totally use this with [Sequel Pro](http://www.sequelpro.com/), and I actually recommmend it.  

You also get the totally rad [MyCLI](https://github.com/dbcli/mycli).

Eventually, if there aren't already, there are going to be some cool tutorials about getting started with Vagrant, using the command line, and getting used to MySQL at [my website](http://brewneaux.com/)

### Installing

Make sure you have [Vagrant](http://docs.vagrantup.com/v2/getting-started/) up and going, and then just

     $ vagrant up

### Connecting to mysql:

This box automatically sets up MySQL to be port forwarded, so you can connect from your base Mac machine (not just the Vagrant box) with ease

- host: 33.33.33.1
- username: root
- password: root

### From sequel pro

<img src="sequel-pro.png"/>

### Warning

For development use only, do not use in production.
Also, make sure your mysql port (3306) is not open on your computer for a local network or in general.

### License

MIT
