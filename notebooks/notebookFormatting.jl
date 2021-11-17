#############
# Libraries #
#############

using PyCall


################
# HTML Setting #
################

css_str = """
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Alegreya:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');
    @import url("juliamono.css");

    :root{
    --jp-content-font-family: 'Alegreya', serif, monospace;
    }
    
}
        
    </style>
"""

css_str2 = """
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Alegreya:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');
    @import url("juliamono.css");

    h1 {
        font-family: 'Alegreya', monospace;
    }

    h2 {
        font-family: 'Alegreya', serif;
    }
    h3 {
        font-family: 'Alegreya', serif;
    }
    h4 {
        font-family: 'Alegreya', serif;
    }
    p {
        font-family: 'Alegreya', serif;
    }
    text {
        font-family: 'Alegreya', serif;
    }
    ul {
        font-family: 'Alegreya', monospace;
    }
    
}
        
    </style>
"""

css_str3 = """
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Alegreya:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');
    @import url("juliamono.css");

    h1 {
        font-family: 'Alegreya', monospace;
    }

    h2 {
        font-family: 'Alegreya', serif;
    }
    h3 {
        font-family: 'Alegreya', serif;
    }
    h4 {
        font-family: 'Alegreya', serif;
    }
    p {
        font-family: 'Alegreya', serif;
    }
    text {
        font-family: 'Alegreya', serif;
    }
    
}
        
    </style>
"""


########################
# Use python Libraries #
########################

# load package
py"""
from IPython.display import HTML
"""

# import HTML function from python
myHTML = py"HTML"

########################
# Apply setting format #
########################

myHTML(css_str3)