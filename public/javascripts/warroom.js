function WGraph(container, legendcontainer, graph_id,line_ids, timeframe, type){
	this.container = container;
	this.line_ids = line_ids;

	var intervalls = {
		day: 24*60*60*1000,
		week: 7*24*60*60*1000,
		quarter: 90*24*60*60*1000,
		year: 395*24*60*60*1000
	};

	var options = {
		legend: {
      show: true,
      noColumns: 4, // number of colums in legend table
      labelFormatter: null, // fn: string -> string
      labelBoxBorderColor: "#ccc", // border color for the little label boxes
      container: legendcontainer, // container (as jQuery object) to put legend in, null means default on top of graph
      backgroundColor: null, // null means auto-detect
      backgroundOpacity: 0.85 // set to 0 to avoid background
    },
		series: {
			lines: { 
				lineWidth: 2,
				fill: 0.0,
				show: true,
			},
			color: "#ff0000"
		},
		xaxis: {
			mode: 'time',
			max: Date.now(),
			min: Date.now()-intervalls[timeframe]
		},
		yaxis: {
		  min: 0,
		  labelWidth: 50
		},
		grid: {
			show: true,
			aboveData: false,
			color: "black",
			tickColor: "#000000",
			borderWidth: 1,
			borderColor: "#000000",
			hoverable: true,
			autoHighlight: false
		}
	};
	
	if(type == 'area'){
	  options.series.stack=true;
	  options.series.lines.fill=0.9;
	  options.series.lines.lineWidth=0;
	}
	var targetCount = line_ids.length;
	var doneCount = 0;
	var cumulativeData = [];
	$.each(line_ids,function(index, line_id){
		$.getJSON("/graphs/"+graph_id+"/graph_lines/"+line_id.id+"/"+timeframe+".json", function(data){
			doneCount++;
			addLine(splitDiscontinuity(data));
			if(doneCount == targetCount){
				this.plot = $.plot(container, cumulativeData.sort(function(a,b){return b.sortindex-a.sortindex;}), options);
			}
		});
	});
	
	function splitDiscontinuity(data){
		var returndata = [];
		var lastdate = null;
		var timeout = intervalls[timeframe]/100;
		while(data.data.length > 0){
			sample = data.data.shift();
			if(lastdate && ((lastdate+timeout) < sample[0])){
				returndata.push(null);
			}
			returndata.push(sample);
			lastdate = sample[0];
		}
		i=0;
		data.data = returndata;
		return data;
	}
	
	function addLine(data){
		cumulativeData.push(data);
	}


}

