// !preview r2d3 data=c('MAAAAAAAAGDSDSWDADTFSMEDPVRKVAGGGTAGGDRWEGEDEDEDVKDNWDDDDDENKEEAEVKPEVKISEKKKIAEKIKEKERQQKKRQEEIKKRLEEPEESKVLTPEEQLADKLRLKKLQEESDLELAKETFGVNNTVYGIDAMNPSSRDDFTEFGKLLKDKITQYEKSLYYASFLEALVRDVCISLEIDDLKKITNSLTVLCSEKQKQEKQSKAKKKKKGVVPGGGLKATMKDDLADYGGYDGGYVQDYEDFM', 'AAAAAAAAGDSDSWDADTFSMEDPVRK', 'DDFTEFGK', 'GVVPGGGLK', 'ITNSLTVLCSEK', 'LEEPEESK', 'LQEESDLELAK', 'RLEEPEESK'), viewer = "browser"

var barHeight = Math.ceil(height / data.length);

var x = d3.scaleLinear()
    .domain([d3.min(data, function(d){ return d; }), 
        d3.max(data, function(d){ return d; }) ])
    .range([0, width]);

svg.selectAll('rect')
  .data(data)
  .enter().append('rect')
    .attr('width', function(d) { return d * width / 10; })
    .attr('height', barHeight)
    .attr('y', function(d, i) { return i * barHeight; })
    .attr('fill', 'steelblue')
    .attr("d", function(d) { return d; })
    .on("click", function(){
      Shiny.setInputValue(
        "bar_clicked", 
        d3.select(this).attr("d"),
        {priority: "event"}
        );
    });