# Front End Docs
Documentation about front end stuffs in Inasafe FBA.

## Deployment
How to set up the front end of this project on your local machine.
<br/>Everything related to the front end of this project is in folder `frontend/app-dashboard`. 
<br/>There are several ways on how to deploy the front end on your local machine.

### The very easy way
Just open the html file from your favourite browser.
<br/>Since the front end only consists of html and JavaScript, you can easily open the main view `frontend/app-dashboard/dashboard.html` using your favourite browser. 
<br/>However using this way, you won't be able to see the slide show. But don't worry other features will work just well.

### The other easy way

Should you prefer to use `localhost`, you may do the following:
- go to your `frontend/app-dashboard` folder
- run this command on your console: `python3 -m http.server 8080`
- open: `http://localhost:8080/dashboard.html`
Using this, you will be able to see the slide show and have all features working.

Note: if you run the command and the console says
```
OSError: [Errno 98] Address already in use
```
It means that port 8080 is in use, you can close the port by using this command:
```
sudo lsof -t -i tcp:8080 | xargs kill -9
```

### The fancy way
There is another fancy way to deploy the front end, please have a look at [deploying front end](../deployment/README.md)

## Understanding the flow
The front end development is quite straight forward. We use several JavaScript libraries that you can find [here](../frontend/app-dashboard/js/libs).
<br/>A lot of the scripts were written using [Backbone.js](https://backbonejs.org/), we defined some [models](../frontend/app-dashboard/js/model) and [views](../frontend/app-dashboard/js/view).

#### Slide show
Slide show components are referred to [intro components](../frontend/app-dashboard/intro) and the images are [here](../frontend/app-dashboard/images/story_board)
<br/>Slide show only works when the site is opened using `http://localhost/`

