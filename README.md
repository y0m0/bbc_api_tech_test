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

