/* Embed this code into your template (manufacturer_info.tpl, product.tpl, search.tpl, category.tpl) */
<a class="btn btn-success" onclick="addToCompareManufacturer(<?php echo $product['product_id']; ?>); window.location.reload(); return true;">Product Compare</a>		

<?php if ($compare >= 1 ) { ?>
	<div id="callCompare" class="hidden-xs hidden-sm">
		<div id="foldit" style="width: 100%; height:35px; bottom: 0px; position: fixed; z-index: 300;background: white;">
			<div id="divHover" class="row" style="background: #282828;">
				<center><h5><i id="arrowHover" class="glyphicon glyphicon-triangle-bottom" style="color:white;">&nbsp;</i><font color="white"><?=strtoupper($text_compare)?> (<?=$compare;?> ITEM)</font></h5></center>
			</div>
			<div class="container m-top-15">
				<?php if ($products_compare) { ?>
					<div class="table-responsive">
						<table class="table-compare">
							<tbody>
								<tr>
									<?php foreach ($products_compare as $product_compare) { ?>
										<?php if ($products_compare[$product_compare['product_id']]['thumb']) { ?>
											<td colspan="2" style="padding-right: 28px;">
												<div style="background: url(<?php echo $products_compare[$product_compare['product_id']]['thumb']; ?>); width:200px; height:200px; background-position:center; background-repeat:no-repeat;" onmouseover="document.getElementById('<?php echo $products_compare[$product_compare['product_id']]['product_id']; ?>').style.display='block';" onmouseout="document.getElementById('<?php echo $products_compare[$product_compare['product_id']]['product_id']; ?>').style.display='none';">
												<div id="<?php echo $products_compare[$product_compare['product_id']]['product_id']; ?>" class="col-xs-2" style="position: absolute; display: none; padding-right: 40px; padding-top: 80px;">
												<a class="btn btn-info col-xs-12" href="<?php echo $cart; ?>" onclick="addToCart('<?php echo $products_compare[$product_compare['product_id']]['product_id']; ?>');">
													<strong>ADD TO CART</strong></a>
												</div>
												<div style="margin-left: 185px;position:relative;"><a id="aCompare" href="<?php echo $product_compare['remove']; ?>" onclick="window.location.reload();" >X</a></div>
												</div>
											</td>
										<?php } ?>
									<?php } ?>
								</tr>
								<tr>
									<?php foreach ($products_compare as $product_compare) { ?>
										<td class="text-center" colspan="2" style="width:200px;word-wrap: break-word; font-size: 13px;padding-top: 5px;padding-right: 28px;"><strong><?php echo $products_compare[$product_compare['product_id']]['name']; ?></strong>
										</td>
									<?php } ?>
								</tr>
								<tr>
									<td colspan="2" style="padding-bottom: 25px;"></td>
								</tr>
								<tr>
									<?php foreach ($products_compare as $product_compare) { ?>
										<td style="font-size: 12px;"><strong><?php echo $text_price; ?></strong></td>
										<td class="text-right" style="width:120px;font-size: 12px;padding-right: 28px;">
											<?php if ($products_compare[$product_compare['product_id']]['price']) { ?>
												<?php if (!$products_compare[$product_compare['product_id']]['special']) { ?>
													<?php echo $products_compare[$product_compare['product_id']]['price']; ?>
											<?php } else { ?>
												<span class="price-old">
													<s><?php echo $products_compare[$product_compare['product_id']]['price']; ?></s>
												</span>
												<?php } ?>
											<?php } ?>
										</td>
									<?php } ?>
								</tr>
								<tr>
									<?php foreach ($products_compare as $product_compare) { ?>
										<td style="font-size: 12px;"><strong><?=$text_buy_now?></strong></td>
										<td class="text-right" style="width:120px;font-size: 12px;padding-right: 28px;">
											<?php if ($products_compare[$product_compare['product_id']]['price']) { ?>
												<?php if (!$products_compare[$product_compare['product_id']]['special']) { ?>
													<?php echo $products_compare[$product_compare['product_id']]['price']; ?>
											<?php } else { ?>
												<span class="price-new">
													<strong style="color:red;"><?php echo $products_compare[$product_compare['product_id']]['special']; ?></strong>
												</span>
												<?php } ?>
											<?php } ?>
										</td>
									<?php } ?>
								</tr>
								<?php foreach ($attribute_groups as $attribute_group) { ?>
									<?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
										<tr>
											<?php foreach ($products_compare as $product) { ?>
											<td class="text-left" style="font-size: 12px;">
												<strong><?php echo $attribute['name']; ?></strong>
											</td>
											
												<?php if (isset($products_compare[$product['product_id']]['attribute'][$key])) { ?>
													<td class="text-right" style="width:120px;font-size: 12px;padding-right: 28px;">
														<?php echo $products_compare[$product['product_id']]['attribute'][$key]; ?>
													</td>
												<?php } else { ?>
													<td></td>
												<?php } ?>
											<?php } ?>
										</tr>
									<?php } ?>
								<?php } ?>
								</div>
							</tbody>
						</table>
					</div>
				<?php } ?>
			</div>
		</div>
	</div>
<?php } ?>
<style>
#aCompare:hover {
    text-decoration: none;
    color:#ccc;
}
#arrowHover:hover {
	color:#ccc;
	cursor: pointer; 
	cursor: hand;
}
#divHover:hover {
	cursor: pointer; 
	cursor: hand;
}
</style>
<!-- Script untuk Compare Page -->
<script >
$('#divHover').click( function() {
    var toggleHeight = $('#foldit').height() == 500 ? "35px" : "500px";
    $('#foldit').animate({ height: toggleHeight });
    var toggleHeight = $('#foldit').height();
     $(this).find('i').toggleClass('glyphicon glyphicon-triangle-top').toggleClass('glyphicon glyphicon-triangle-bottom');
});
</script>
