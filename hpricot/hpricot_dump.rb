htmldoc =<<eof
<div id='mother'>
  <div>child1 empty</div>
  <p>para</p>
  <div>child2 has 2 kids
    <p>para</p>
    <div>c2 grandchild1</div>
    <p>para</p>
    <div>c2 grandchild2</div>
    <p>para</p>
  </div>
  <div>child3
    <div>c3 grandchild1
      <div>c3 gc1 child1</div>
      <div>c3 gc1 child2</div>
    </div>
  </div>
</div>
eof

require 'hpricot'

hd = Hpricot(htmldoc)
puts (hd/"#mother")[0].children_of_type("div")
puts (hd/"#mother")[0].children


