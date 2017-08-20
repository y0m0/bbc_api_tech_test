[my solution](#my-solution) | [requirements](#requirements) | [how to use](#how-to-use)
## BBC Tech Test

### The Task

We require you to build a RESTful web service for managing page layout
resources, we use them at the BBC to describe the page content.
Here is an example page config (JSON format) called foo.json :

```
 {
   "id": "foo",
   "value": "I am foo"
 }
```
#### User stories :

These are just a couple of user stories to help you get going and to give
you an idea of the sort of thing we're asking for (specific requirements
can be found below in the next section).

```
Given there is a RESTful web service available
When it receives a GET for /pages/foo
Then the service should return the relevant page config

Given there is a RESTful web service available
When it receives a PUT for /pages/foo
And /pages/foo already exists
Then the appropriate response with status code should be returned
```
#### The specific requirements are as follows:

- The service is a simple Sinatra app, the skeleton is already in place for you.
  Please download it from here.
- The service should implement create/update resource functionality.
- The resources (i.e. the configuration files) can be stored in memory, in fact
  we provide a basic class, feel free to use it or replace it with your own db
  if you prefer.
- Please add any additional functionality or behaviour that you feel is
  important to meet best practices for designing a RESTful web service.
- Please provide an overview of the submission in a README.
- Please also ensure you have some form of tests (whether they be unit or
  integration we'll leave it up to you to decide).


## My Solution

### Getting Started

The Api is deployed on Heroku at https://immense-reaches-61750.herokuapp.com/

but it can also be installed locally by following the steps below

##### Requirements
```
PostgreSQL
Ruby 2.4.0
```

To use the Api install both Ruby 2.4.0 and PostgreSQL ([why PostgreSQL](#my-approach)), clone this repo and then:
##### install the dependencies
```
gem install bundler
bundle install
```
##### create the dbs
```
rake db:create
rake db:auto_migrate
```
##### start the app
```
bundle exec rackup
```
#####  to run the tests
```
bundle exec rspec
```

### How to use

If installed locally the Api is available at http://localhost:929  

To use the Api you can start to send HTTP by either using [cURL](https://curl.haxx.se/) from the cli or install a gui tool like [Postman](https://www.getpostman.com/)

some examples request are:

**GET /pages**

```
curl -i -H 'Accept: application/json' http://localhost:9292/pages/
```



**GET /pages/:id**

*I pre-saved some resources on Heroku, but if you are running this on your local machine you might want to create some entries to play with by using POST or PUT [create resources with PUT](#my-approach)*

```
curl -i -H 'Accept: application/json' http://localhost:9292/pages/finance-123
```



**POST /pages**

```
curl -i -d 'id=sport-123&value=sport config' http://localhost:9292/pages
```



**PUT /pages/sport-123**

```
curl -i -X PUT -d 'value=new sport config' http://localhost:9292/pages/sport-123
```



**DELETE /pages/sport-123**

```
curl -i -X DELETE http://localhost:9292/pages/sport-123
```



### My Approach

**This Api was build entirely by following TDD principles, red - green - refactor**

I decided to use PostgreSQL as database instead of the basic class that was provided. Together with Datamapper it provides nicer ways to validate the entries while also returning helpful error messages that can be shown to the user. When deciding on how to construct the IDs to use for the entries in the database, and consequently as ID for the resources, I took the ones from BBC news as example. 
One such example is *business-40972776* , so in my case I decided to allow for a series of letters with an optional hypen followed by some numbers.

The Api itself consists of five routes, each route returns a json formatted output with the appropriate
HTTP status code.  In order to decide how to implement the routes, I referred to the offical documentation for the HTTP methods https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html

After some research, I decided to allow PUT to update a specific resource, but also to create it if didn't already exist. In case of update, PUT responds with a status *200* and returns the updated resource in json format. When the resource does not exist, PUT creates it and responds with a status *201 Created*, adds the URI of the newly created resource to the header (*Location: URI of  the new resource*) and returns the json for the created resource.

While PUT could be used to create new resources I decided to include POST aswell for these reasons:

- POST creates a child resource, so POST to `/pages` creates a resource that lives under the `/pages` resource. 

- PUT is for creating or replacing a resource at a URL known by the client. Therefore: PUT is only a candidate for CREATE where the client already knows the url before the resource is created.

In my specific case, PUT might have been enough since I have to manually specify the ID for the resource. However when taking into account scalability, it is reasonable to assume that in the future the IDs will be automatically generated on creation and that will require a POST route to process it.

The last route that I decided to include is DELETE despite not being one the requirements. I feel like it is an essential part of a complete RESTful api. If security is a concern, DELETE could be protected by some sort of authentication to avoid accidental or malicious use. DELETE as stated in the [offical documentation](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.7) always responds with a status *204* in case the resource was deleted or the resource was not present in the first place.

#### Notes

Given more time I would have liked to add some sort of authentication.  An example could be requiring a valid api-key to process the request like illustrated [here](https://stackoverflow.com/questions/3479737/sinatra-api-authentication). Another option could be to implement a more complex user based authentication system.