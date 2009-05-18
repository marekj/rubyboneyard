# <meta name="keyword" content="text" /> 
htmldoc =<<eof
<html>
 <head>
  <title>This is a title</title>
  <script language="JavaScript" src="/portal/common/scripts.js"></script>
  <link rel="stylesheet" href="/portal/common/styles.css">
 </head>
 <body>
 </body>
</html>

eof

require 'hpricot'

doc = Hpricot(htmldoc)
(doc/"head/title").after "<meta name='marekj' content='contentastamana'>"
puts doc



