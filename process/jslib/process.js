var max_nodes = 100;
var rsm_nodes = {};
var gen_nodes = {};

var calculate = function(fd, fr) {
	var common_nodes = [];

	for(var i = 0; i < fd.length; i++) {
		for(var j = 0; j < fr.length; j++) {
			if(parseInt(fd[i]) == parseInt(fr[j])) {
				common_nodes.push(fd[i]);
			}
		}
	}

	precision = common_nodes.length/fd.length;
	recall = common_nodes.length/fr.length;

	F = 2*((precision*recall)/(precision+recall));

	return result = {
		"precision": precision,
		"recall": recall,
		"F": F
	};
};

var getSimilarArray = function(gen_nodes, rsm_nodes, target_node) {
	var len_gen_nodes = gen_nodes.length;
	var len_rsm_nodes = null;
	var similar_index = 0;
	var similar_array = [];

	// This loop is generating the array containing all the similarity index.
	for(var nodes in rsm_nodes) {
		var target_node_found = false;

		// skip those nodesets array where the target node is not present in the nodesets generated by RSM algorithm.
		for(var i = 0; i < rsm_nodes[nodes].length; i++) {
			if(target_node == parseInt(rsm_nodes[nodes][i])) {
				target_node_found = true;
			}
		}
		
		if(rsm_nodes.hasOwnProperty(nodes) && target_node_found) {
			len_rsm_nodes = rsm_nodes[nodes].length;
			if(len_gen_nodes > len_rsm_nodes) {
				
				for(var i = 0; i < gen_nodes.length; i++) {
					for(var j = 0; j < rsm_nodes[nodes].length; j++) {
						if(parseInt(gen_nodes[i]) == parseInt(rsm_nodes[nodes][j])) {
							similar_index++;
						}
					}
				}
				similar_array.push(similar_index/len_gen_nodes)
			
			} else {

				for(var i = 0; i < rsm_nodes[nodes].length; i++) {
					for(var j = 0; j < gen_nodes.length; j++) {
						if(parseInt(gen_nodes[j]) == parseInt(rsm_nodes[nodes][i])) {
							similar_index++;
						}
					}
				}
				similar_array.push(similar_index/len_rsm_nodes)
			}
		}
		similar_index = 0;
	}

	var comparison_index = similar_array[0];
	var final_index = 0;
	var similar_index_array = [];

	var similar_index_object = {};

	// Loop to generate the similar index object with index as key and the array of similar nodesets array as the value.
	for(var i = 0; i < similar_array.length; i++) {
		if(similar_index_object.hasOwnProperty(similar_array[i])) {
			similar_index_object[similar_array[i]].push(i+1);
		} else {
			similar_index_object[similar_array[i]] = [i+1];
		}
	}

	console.log(similar_index_object);

	// loop over similarity index object and find the greatest index.
	for(var index in similar_index_object) {
		if(parseFloat(comparison_index) < parseFloat(index)) {
			comparison_index = parseFloat(index);
		}
	}

	var shortest_length = 0;
	
	// This loop is fetching the best nodeset from the equal similar index nodesets array.
	for(var i = 0; i < similar_index_object[comparison_index].length; i++) {
		if((shortest_length < rsm_nodes[similar_index_object[comparison_index][i]].length) && (len_gen_nodes <= rsm_nodes[similar_index_object[comparison_index][i]].length)) {
			shortest_length = similar_index_object[comparison_index][i];
		}
	}
	console.log(similar_array);
	console.log(rsm_nodes);
	return rsm_nodes[shortest_length];

};

// fetch nodesets data for RSM algorithm
$.get("../rsm_com/communities.txt", function(data) {

	data = data.split("#");
	for(var i = 0; i < data.length; i++) {
		if(data[i] != "\n") {
			rsm_nodes[i+1] = data[i].trim().split("\n"); 
		}
	}

	// Fetch nodesets for any other algorithm.
	$.get("../generated_com/community.dat", function(data) {
		data = data.split("\n");
		var arr = [];
		for(var i = 0; i < data.length; i++) {
			data[i] = data[i].trim();
			if(gen_nodes.hasOwnProperty(data[i])) {
				gen_nodes[data[i]].push(i+1);
			} else {
				gen_nodes[data[i]] = [i+1];
			}
		}

		// Select the node for which yoou have to run the calculations.
		var fd = getSimilarArray(gen_nodes['5'], rsm_nodes, 5);
		var fr = gen_nodes['5'];

		console.log(fd);
		console.log(fr);
		console.log(calculate(fd, fr));


	});

});


