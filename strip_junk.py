from bs4 import BeautifulSoup

def try_lecture(s):
    print s
    f = "./" + s + "/lecture.html"
    b = BeautifulSoup(open(f, "r"), 'html.parser')
    preserve = open(s + "lectureOLD.html", "w")
    preserve.write(b.prettify(formatter="html"))
    ss = b.find_all("section")
    ss[-1].extract()
    print b
    outfile = open(s + "/lecture.html", "w")
    outfile.write(b.prettify(formatter="html"))


def do_it():
    for i in range(22):
        try:
            try_lecture("%d" % i)
        except:
            print "continuing"
            for j in range(1, 5):
                s = "%d.%d" % (i, j)
                try:
                    try_lecture(s)
                except:
                    print "continuing"


def clean():
    import os
    for i in range(22):
        try:
            os.remove("%d/lecturenew.html" % i)
        except:
            print "continuing"
            for j in range(1, 5):
                s = "%d.%d" % (i, j)
                try:
                    os.remove(s + "/lecturenew.html")
                except:
                    print "continuing"
