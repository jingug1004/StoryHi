/**
 * central-click.js
 */
d3.svg.BubbleChart.define("central-click", function (options) {
  var self = this;

  self.setup = (function (node) {
    var original = self.setup;
    return function (node) {
      var fn = original.apply(this, arguments);
      self.event.on("click", function(node) {
        if (node.selectAll("text.central-click")[0].length === 1) {
        	//alert(node.data()[0].item.text); //제일 큰 동그라미 검색어 들고오는 것
        	var frm = document.do_searchTag;
    		frm.search_word.value = node.data()[0].item.text;
    		console.log("frm.page_num.value=" + frm.search_word.value);
    		frm.action = "/main/do_search.hi";
    		frm.submit();
        }
      });
      return fn;
    };
  })();

  self.reset = (function (node) {
    var original = self.reset;
    return function (node) {
      var fn = original.apply(this, arguments);
      node.select("text.central-click").remove();
      return fn;
    };
  })();

  self.moveToCentral = (function (node) {
    var original = self.moveToCentral;
    return function (node) {
      var fn = original.apply(this, arguments);
      var transition = self.getTransition().centralNode;
      transition.each("end", function() {
        node.append("text").classed({"central-click": true})
          .attr(options.attr)
          .style(options.style)
          .attr("x", function (d) {return d.cx;})
          .attr("y", function (d) {return d.cy;})
          .text(options.text)
          .style("opacity", 0).transition().duration(self.getOptions().transitDuration / 2).style("opacity", "0.8");
      });
      return fn;
    };
  })();
});