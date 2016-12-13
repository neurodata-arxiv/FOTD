MASTER_DIR=/Users/gkiar/code/ocp/FOTD
GH_DIR=/Users/gkiar/code/ocp/FOTD-gh
FILE=thething.md
DATE=2016-12-13
TITLE="I made a nice fig (FoTD)"

POST=$(GH_DIR)/_posts/$(DATE)-$(FILE)

default:
	cp $(GH_DIR)/_posts/head.md $(POST);
	cat $(MASTER_DIR)/md/$(FILE) >> $(POST);
	sed -i "" '3s/FoTD/$(TITLE)/' $(POST);
	sed -i "" '6s/date/$(DATE)/' $(POST);
	sed -i "" 's/``` r/{% highlight r %}/' $(POST);
	sed -i "" 's/```/{% endhighlight %}/' ${POST};
	cp $(MASTER_DIR)/md/`cat $(POST) | awk '/<img/ { print }' | cut -d '"' -f2` $(GH_DIR)/images/
	sed -i "" 's/..\/figures/\/images/' ${POST};
	echo $(FIG)
