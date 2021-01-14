---
title: Wordpress
permalink: "/wiki/wordpress/"

---
## Discover enqueued styles and scripts in Wordpress

    function discover_scripts() 
    {
    	// Queued styles
    	var_dump(wp_styles()->queue);
        // Queued scripts
        var_dump(wp_scripts()->queue);
    }
    add_action( 'wp_enqueue_scripts', 'discover_scripts', 100 );