from bs4 import BeautifulSoup
import sys

# should check something about these....
a, b = int(sys.argv[1]), int(sys.argv[2])

def insert_content(a, content):
    ambient = BeautifulSoup(open("template.html", 'r'))
    newtitle = ambient.new_tag("title")
    newtitle.string = "Lecture %d"%a
    ambient.title.replace_with(newtitle)
    spot = ambient.find(id='insertedcontent')
    spot.replace_with(content)
    ambient.find(id='insertedcontent').unwrap()
    print ambient
    return ambient.prettify(formatter='html')

for i in range(a, b+1):
    loc = "%d/lecture.html"%i
    content = BeautifulSoup(open(loc, 'r')).find(id='insertedcontent')
    outfile = open("%d/index.html"%i, 'w')
    outfile.write(insert_content(a, content))


