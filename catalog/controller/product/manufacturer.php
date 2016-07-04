		/* You can embed the code into controller pages in product folder (manufacturer.php, category.php, special.php, search.php, or product.php)
		// Scripting Compare Page
		$this->language->load('product/compare_pop');
		
		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$this->data['button_remove'] = $this->language->get('button_remove');

		if (!isset($this->session->data['compare'])) {
			$this->session->data['compare'] = array();
		}	
				
		if (isset($this->request->get['remove'])) {
			$key = array_search($this->request->get['remove'], $this->session->data['compare']);
				
			if ($key !== false) {
				unset($this->session->data['compare'][$key]);
			}
		
			//$this->session->data['success'] = $this->language->get('text_remove');
		
			$this->redirect($this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer_id .  '&stock=1'));
		}
								
		$this->data['products_compare'] = array();
		
		$this->data['attribute_groups'] = array();

		foreach ($this->session->data['compare'] as $key => $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			
			if ($product_info) {
				if ($product_info['image']) {
					//$image = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_compare_width'), $this->config->get('config_image_compare_height'));
					if(!file_exists("image/".$product_info['image'])) {
						$imagename = explode('.jpg',$product_info['image']);
						$product_info['image'] = $imagename[0].".png";
						if(!file_exists("image/".$product_info['image'])) $product_info['image'] = "product/no_image.jpg";
					}
					$image = $this->model_tool_image->resize($product_info['image'], 200, 200);
				} else {
					$image = false;
				}
				
				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
				
				if ((float)$product_info['special_price']) {
					$special = $this->currency->format($this->tax->calculate($product_info['special_price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}
				
				$measurement = ($product_info['dial_length']/10) . " x " . ($product_info['full_length']/10) . " x " . ($product_info['width']/10) . " x " . ($product_info['thick']/10) . " (cm)";
				
				if ($product_info['quantity'] <= 0) {
					$availability = $product_info['stock_status'];
				} elseif ($this->config->get('config_stock_display')) {
					$availability = $product_info['quantity'];
				} else {
					$availability = $this->language->get('text_instock');
				}				
				
				$attribute_data = array();
				
				$attribute_groups = $this->model_catalog_product->getProductAttributesCompare($product_id);
				
				foreach ($attribute_groups as $attribute_group) {
					foreach ($attribute_group['attribute'] as $attribute) {
						$attribute_data[$attribute['attribute_id']] = $attribute['text'];
					}
				}
				
				foreach ($attribute_groups as $attribute_group) {
					$this->data['attribute_groups'][$attribute_group['attribute_group_id']]['name'] = $attribute_group['name'];
					
					foreach ($attribute_group['attribute'] as $attribute) {
						$this->data['attribute_groups'][$attribute_group['attribute_group_id']]['attribute'][$attribute['attribute_id']]['name'] = $attribute['name'];
					}
				}

				$this->data['products_compare'][$product_id] = array(
					'product_id'   => $product_info['product_id'],
					'name'         => $product_info['name'],
					'thumb'        => $image,
					'price'        => $price,
					'special'      => $special,
					'description'  => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, 200) . '..',
					'model'        => $product_info['model'],
					'manufacturer' => $product_info['manufacturer'],
					'manufacturer_id' => $product_info['manufacturer_id'],
					'availability' => $availability,
					'rating'       => (int)$product_info['rating'],
					'reviews'      => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
					'weight'       => $this->weight->format($product_info['weight'], $product_info['weight_class_id']),
					'length'       => '',//$this->length->format($product_info['length'], $product_info['length_class_id']),
					'width'        => $this->length->format($product_info['width'], $product_info['length_class_id']),
					'height'       => '',//$this->length->format($product_info['height'], $product_info['length_class_id']),
					'measurement'  => $measurement,
					'attribute'    => $attribute_data,
					'href'         => $this->url->link('product/product', 'product_id=' . $product_id),
					//'remove'       => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer_id .  '&stock=1', 'remove=' . $product_id)
					'remove'       => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer_id .  '&stock=1&remove=' . $product_id)
				);
					
			} else {
				unset($this->session->data['compare'][$key]);
			}
		} 
	
		//End Scripting Compare Page
		//=================================
