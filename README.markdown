WARNING
=======

DO NOT clone this as it has dependencies on an unreleased Spree extension.

SUMMARY
=======

This Spree extension generates dynamic, seo-friendly sitemaps on the fly in XML.

This extension is NOT compatible with the [static_content][1] extension.

In order to avoid an SEO penalty for duplicate content, products are only listed once at /product/_productName_

For Rails 3 and Spree >= 0.50.0

INSTALLATION
------------

`gem 'spree_dynamic_sitemaps', :git => 'git://github.com/asha79/spree_dynamic_sitemaps.git'`

`bundle install`

Hat tip [stephp][2] for doing all the heavy lifting with her [spree-sitemaps][3] extension.

[1]: http://ext.spreecommerce.com/extensions/2-static-content
[2]: http://github.com/stephp
[3]: http://ext.spreecommerce.com/extensions/3-spree-sitemaps
