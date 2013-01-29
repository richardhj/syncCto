<?php if (!defined('TL_ROOT')) die('You cannot access this file directly!');

/**
 * Contao Open Source CMS
 *
 * @copyright  MEN AT WORK 2013 
 * @package    syncCto
 * @license    GNU/LGPL 
 * @filesource
 */

$GLOBALS['TL_DCA']['tl_syncCto_restore_file'] = array(
    // Config
    'config' => array(
        'dataContainer' => 'Memory',
        'closed' => true,
        'disableSubmit' => false,
        'onload_callback' => array(
            array('tl_syncCto_restore_file', 'onload_callback'),
        ),
        'onsubmit_callback' => array(
            array('tl_syncCto_restore_file', 'onsubmit_callback'),
        ),
        'dcMemory_show_callback' => array(
            array('tl_syncCto_restore_file', 'show_all')
        ),
        'dcMemory_showAll_callback' => array(
            array('tl_syncCto_restore_file', 'show_all')
        ),
    ),
    // Palettes
    'palettes' => array(
        'default' => '{filelist_legend},filelist;',
    ),
    // Fields
    'fields' => array(
        'filelist' => array(
            'label' => &$GLOBALS['TL_LANG']['tl_syncCto_restore_file']['filelist'],
            'inputType' => 'fileTreeMemory',
            'eval' => array(
                'files' => true,
                'filesOnly' => true,
                'fieldType' => 'radio',
                'path' => $GLOBALS['TL_CONFIG']['uploadPath'] . '/syncCto_backups/files', 
                'extensions' => 'rar,zip'
            ),
        ),
    )
);

/**
 * Class for restore files
 */
class tl_syncCto_restore_file extends Backend
{

    /**
     * Set new and remove old buttons
     * 
     * @param DataContainer $dc 
     */
    public function onload_callback(DataContainer $dc)
    {
        $dc->removeButton('save');
        $dc->removeButton('saveNclose');

        $arrData = array
            (
            'id' => 'restore_backup',
            'formkey' => 'restore_backup',
            'class' => '',
            'accesskey' => 'g',
            'value' => specialchars($GLOBALS['TL_LANG']['MSC']['restore']),
            'button_callback' => array('tl_syncCto_restore_file', 'onsubmit_callback')
        );

        $dc->addButton('restore_backup', $arrData);
    }

    /**
     * Handle restore files configurations
     * 
     * @param DataContainer $dc
     * @return array
     */
    public function onsubmit_callback(DataContainer $dc)
    {
        // Check if a file was selected
        if ($this->Input->post("filelist") == "")
        {
            $_SESSION["TL_ERROR"] = array(vsprintf($GLOBALS['TL_LANG']['ERR']['unknown_file'], array($this->Input->post("filelist"))));
            $this->redirect($this->Environment->base . "contao/main.php?do=syncCto_backups&table=tl_syncCto_restore_file");
        }

        $arrBackupSettings = array();
        $arrBackupSettings['backup_file'] = $this->Input->post("filelist");
        $this->Session->set("syncCto_BackupSettings", $arrBackupSettings);

        $this->redirect($this->Environment->base . "contao/main.php?do=syncCto_backups&amp;table=tl_syncCto_restore_file&amp;act=start");
    }

    /**
     * Change active mode to edit
     * 
     * @return string 
     */
    public function show_all($dc, $strReturn)
    {
        return $strReturn . $dc->edit();
    }

}

?>