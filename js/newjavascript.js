/* 
 
 */


//To List All Styles on The Page:
javascript: var sty = document.styleSheets; var display = ""; for(var i=0;i<sty.length;i++){display = display+"<hr/>";for(var j=0;j<sty[i].cssRules.length;j++){var t = "";t=sty[i].cssRules[j].cssText;display = display+t+'<br/>';}}document.write(display);

//To List All The Links on the Page:
javascript:var hyperLinks = document.links; var display = ""; for(var i=0;i<hyperLinks.length;i++){display = display+hyperLinks[i]+"<br/>";}document.write(display);

//To Convert Date From Long format to Readable and vice Versa:
javascript:prompt("hi", new Number(new Date('Thu Jan 01 00:00:00 CST 2009')))
javascript:prompt("hi", new String(new Date(1230789600000)))
