## Installation
Follow these easy steps to install and start the app:

### Prerequisites
The setups steps expect following tools installed on the system.

* Github
* Docker

### Check out the repository
``` git clone https://github.com/vbiletskiyy/youtube-api.git```

### Open cd
```cd youtube-api```

### Set up a youtube api key
Create a ```.env``` file, and paste this key ```YOUTUBE_API_KEY=AIzaSyCxWiCUYuwEQOO1G7QmEkH_LuBVsihlqno```

### Set up app with Docker
```docker build -t youtube_api .```

### To start the server
```docker run -p 4567:4567 youtube_api```

And now you can visit the site with the URL http://0.0.0.0:4567

Use Ctrl-C to stop

### Run tests
```docker run -it youtube_api bash```

```rspec```

### Set up without Docker

Run ```bundle install```

```ruby app.rb```

Open localhost:4567
