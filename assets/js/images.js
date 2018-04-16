var cl = cloudinary.Cloudinary.new({cloud_name: "atem18"});
var img = cl.image("home", 
	{ 
		    width: "auto", 
		    dpr: "auto", 
		    responsive: "true",
		    crop: "scale", 
		    responsive_placeholder: "blank"
	});
$(img).addClass("page__hero-image");

$heroDiv = $('<div class="page__hero"></div>');
$heroDiv.append(img);
$heroDiv.insertAfter(".masthead");

cl.responsive();
