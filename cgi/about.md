# cgi

- Where does this idea come from?

I have a raspberry-pi and an internet server. Recently it comes to me that I can make the PI and the server communicate. That will be interesting. But I don't want to use some methods which are difficult to extend, like binary structure data. In the company I worked, CGI methods is used for devices and clients to communicate, even between modules of one application. And CGI commucation is based on http(s) and html techs. It may be old but at least it is easy to extend. So I want to try making one by myself.  

- What do I need?

We will talk about both client side and server side.  

On the client side, it has to translate a command into a HTTP request with an HTML page. I will use libcurl to do this job. And I will use fastJson to serialize data into json and then put it into the html page.  

On the server side, we have to receive HTTP requests and translate the request and the content and deliver them to some applications. We will use boa to do the http server job. And use gumbo-parse to parse the html and take out the json content. Then use fastJson to parse json into structured data.  

- 1st step: boa setup

```bash
tar xd boa*.tgz
cd src; ./configure; make;
```

copy src/boa to PROJECT/cgi/server  

