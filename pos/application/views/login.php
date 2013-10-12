<!DOCTYPE html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="<?=base_url()?>css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" rev="stylesheet" href="<?php echo base_url();?>css/login.css" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><?php echo $this->lang->line('login_title_page'); ?> <?php echo $this->lang->line('login_login'); ?></title>
<script src="<?php echo base_url();?>js/jquery-1.2.6.min.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
<script type="text/javascript">
	$(document).ready(function()
	{
		$("#login_form input:first").focus();
	});
</script>
</head>
<body>
<?php
if ($_SERVER['HTTP_HOST'] == 'sistemasycontroles.net/pos')
{
?>
<h2>Press login to continue</h2>
<?php
}
?>
<?php echo form_open('login') ?>
<div class="container">
	<?php echo validation_errors(); ?>
		<div class="form-signin">
		    <!--h1>Ventas <?php //echo $this->config->item('application_version'); ?></h1-->
			<h2 class="form-signin-heading"><?php echo $this->lang->line('login_login'); ?></h2>
			<div id="welcome_message" class='alert alert-info'>
				<?php echo $this->lang->line('login_welcome_message'); ?>
			</div>
			<!--div class="form_field_label"><?php //echo $this->lang->line('login_username'); ?>: </div-->
			<div class="form_field">
				<?php echo form_input(array(
				'name'=>'username', 
				'value'=> $_SERVER['HTTP_HOST'] == 'sistemasycontroles.net/pos' ? 'admin' : '',
				'size'=>'20',
				'class' => 'form-control',
				'placeholder' => 'Nombre de Usuario')); ?>
			</div>
			<br>
			<!--div class="form_field_label"><?php //echo $this->lang->line('login_password'); ?>: </div-->
			<div class="form_field">
				<?php echo form_password(array(
				'name'=>'password', 
				'value'=>$_SERVER['HTTP_HOST'] == 'sistemasycontroles.net/pos' ? 'pointofsale' : '',
				'size'=>'20',
				'class' => 'form-control',
				'placeholder' => 'Contraseña de Usuario')); ?>
			</div>
				<?php 
					$atributos = array(
						'name' => 'loginButton',
						'id' => 'loginButton',
						'value' => $this->lang->line('login_login'),
						'class' => 'btn btn-lg btn-primary btn-block'
					);
					echo form_submit($atributos); 
				?>
		</div>
</div>
<?php echo form_close(); ?>
</body>
</html>
