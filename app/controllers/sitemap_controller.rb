class SitemapController < Spree::BaseController
  def index
    @taxons = Taxon.all
    
    # Get Pages from static_content extension
    @pages = _select_static_pages
    
    respond_to do |format|
      format.xml do
        nav = _build_taxon_hash
        nav = _build_pages_hash nav
        render :layout => false, :xml => _build_xml(nav)
      end
    end
  end
    
  private
  
  def taxons_to_reject
    @taxons_to_reject ||= []
  end
  
  def slugs_to_reject
    @slugs_to_reject ||= []
  end
  
  def _build_xml(nav)
    returning '' do |output|
      xml = Builder::XmlMarkup.new(:target => output, :indent => 2) 
      xml.instruct!  :xml, :version => "1.0", :encoding => "UTF-8"
      xml.urlset( :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" ) {
        xml.url {
          xml.loc root_url
          xml.lastmod Date.today
          xml.changefreq 'daily'
          xml.priority '1.0'
        }
        nav.each do |k, v| 
          xml.url {
            xml.loc v['link']
            xml.lastmod v['updated'].xmlschema			  #change timestamp of last modified
            xml.changefreq 'weekly'
            xml.priority '0.8'
          } 
        end
      }
    end
  end

  def _build_taxon_hash
    nav = Hash.new
    @taxons.each do |taxon|
      next if taxons_to_reject.any? {|r| taxon.permalink.match( r ) }
      tinfo = Hash.new
      tinfo['name'] = taxon.name
      tinfo['depth'] = taxon.permalink.split('/').size
      tinfo['link'] = root_url + taxon.permalink 
      tinfo['updated'] = taxon.updated_at
      _add_products_to_tax(nav, taxon)
      nav[taxon.permalink] = tinfo
    end
    nav
  end

  def _add_products_to_tax(nav, taxon)
    taxon.active_products.each do |product|
      pinfo = Hash.new
      pinfo['name'] = product.name
      pinfo['link'] = product_url(:id => product.permalink) # primary
      pinfo['updated'] = product.updated_at
      nav[pinfo['link']] = pinfo				# store primary
    end
    nav
  end
  
  def _build_pages_hash(nav)
    return nav if @pages.empty?
    
    @pages.each do |page|
      nav[page.slug] = {'name' => page.title,
                        'link' => root_url + page.slug.name,
                        'updated' => page.updated_at}
    end
    nav
  end
  
  def _select_static_pages
    pages = []
    begin
      Page.visible.each do |page|
        next if slugs_to_reject.any? {|r| page.slug.name.match( r ) }
        pages << page
      end
      
    rescue NameError
      pages = []
    end
    pages
  end
end
