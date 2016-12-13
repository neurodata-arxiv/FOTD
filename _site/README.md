# To create a post:

1. `cd` into `_posts`
2. open `makefile`
3. change several lines at the top to reflect the file you wish to convert to a post
4. run `make`
5. open the new post in the `_posts` directory (titled `YEAR-MONTH-DAY-TITLE.md`) to verify content looks right

#### to run server and view live page locally (optional)
1. install bundler (from [bundler.io](bundler.io))
2. `cd` to main directory of gh-pages branch
3. `bundle install`
4. `bundle exec jekyll serve`
5. go to `localhost:4000`

