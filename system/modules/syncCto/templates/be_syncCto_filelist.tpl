<h1 class="file"><strong><?php echo $GLOBALS['TL_LANG']['MSC']['totalsize']; ?></strong> ~ <?php echo $this->getReadableSize($this->totalsize); ?></h1>

<form id="syncCto_filelist_form" action="<?php echo $this->Environment->base; ?>contao/main.php?do=synccto_clients&amp;table=tl_syncCto_clients_sync<?php echo $this->direction; ?>&amp;act=start&amp;step=<?php echo $this->step; ?>&amp;id=<?php echo $this->id; ?>" method="post">
    <div class="formbody">
        <input type="hidden" name="FORM_SUBMIT" value="<?php echo $this->formId; ?>" />

        <div class="submit_container">
            <input class="tl_submit" name="transfer" type="submit" value="<?php echo $GLOBALS['TL_LANG']['MSC']['submit_files']; ?>" />
            <input class="tl_submit" name="delete" type="submit" value="<?php echo $GLOBALS['TL_LANG']['MSC']['delete_files']; ?>" />
        </div>

        <table id="syncCto_filelist">
            <colgroup>
                <col width="12%" />
                <col width="15%" />
                <col width="35" />
                <col width="*" />
            </colgroup>
            <thead>
                <tr class="head">
                    <th class="state"><?php echo $GLOBALS['TL_LANG']['MSC']['state']; ?></th>
                    <th class="filesize"><?php echo $GLOBALS['TL_LANG']['MSC']['filesize']; ?></th>
                    <th class="checkbox">&nbsp;</th>
                    <th class="last"><?php echo $GLOBALS['TL_LANG']['MSC']['file']; ?></th>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                    <td class="checkbox"><input class="tl_checkbox" onclick="Backend.toggleCheckboxGroup(this, 'syncCto_filelist')" type="checkbox" /></td>
                    <td class="last"><?php echo $GLOBALS['TL_LANG']['MSC']['select_all_files']; ?></td>
                </tr>
            </thead>
            <tbody>            
            <?php foreach ($this->filelist as $key => $file): ?>
                <tr>                             
                    <?php if($this->compare_complex  == 1 && !empty($file["css_big"])) : ?>
                        <td class="state <?php echo $file["css"]; ?>"><?php echo $GLOBALS['TL_LANG']['MSC'][$file["css_big"] . '_files']; ?></td>
                    <?php else: ?>
                        <td class="state <?php echo $file["css"]; ?>"><?php echo $GLOBALS['TL_LANG']['MSC'][$file["css"] . '_file']; ?></td>
                    <?php endif; ?>
                    <td class="filesize"><?php echo ($file["size"] == -1) ? "N.A." : $this->getReadableSize($file["size"]); ?></td>
                    <?php if($this->compare_complex == false): ?>
                        <td class="checkbox"><input class="tl_checkbox" type="checkbox" name="del-file-<?php echo $key; ?>" value="<?php echo $key; ?>" /></td>                   
                    <?php else: ?>
                        <td class="checkbox"><?php if (empty($file["css_big"])): ?><input class="tl_checkbox" type="checkbox" name="del-file-<?php echo $key; ?>" value="<?php echo $key; ?>" /><?php else: ?> X <?php endif; ?></td>  
                    <?php endif; ?>
                    <td class="last" title="<?php echo $file["path"]; ?>"><?php echo (strlen($file["path"]) >= 60) ? substr($file["path"], 0, 30) . "[...]" . substr($file["path"], strlen($file["path"]) - 30, strlen($file["path"]) - 1) : $file["path"]; ?></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</form>