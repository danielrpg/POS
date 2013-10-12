<?php $this->load->view("partial/header"); ?>
<br />
<h5 class='alert alert-info'><?php echo $this->lang->line('common_welcome_message'); ?></h5>
<div id="home_module_list" class='row'>
	<?php
	foreach($allowed_modules->result() as $module)
	{
	?>
		<div class="col-6 col-sm-6 col-lg-4">
		    <h2>
		    	<?php echo $this->lang->line("module_".$module->module_id) ?>
		    </h2>
		    <p>
				<a href="<?php echo site_url("$module->module_id");?>">
				<img src="<?php echo base_url().'images/menubar/'.$module->module_id.'.png';?>" border="0" alt="Menubar Image"  align='top'/></a>
				<p><?php echo $this->lang->line('module_'.$module->module_id.'_desc');?></p>
				<a href="<?php echo site_url("$module->module_id");?>" class='btn btn-lg btn-success'><?php echo $this->lang->line("module_".$module->module_id) ?></a><br><br>
		    </p>
		</div>
	<?php
	}
	?>
</div>
<?php $this->load->view("partial/footer"); ?>