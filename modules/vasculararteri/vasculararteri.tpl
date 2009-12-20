<?php
/* 
 *  Copyright (c) 2009 Denic Wibowo<denicwibowo@gmail.com>.
 *  All rights reserved.
 *  
 *  This program is free software; you can redistribute it and/or modify it 
 *  under the terms of the GNU General Public License as published by the 
 *  Free Software Foundation; either version 2 of the License, or 
 *  (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful, but 
 *  WITHOUT ANY WARRANTY; without even the implied warranty of 
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General 
 *  Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License along 
 *  with this program; if not, write to the Free Software Foundation, Inc., 
 *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *  

 *  vasculararteri.tpl
 *  
 *  Created on Oct 26, 2009, 5:28:48 AM
 */

foreach($data as $key => $value){
    if(isset($value['#addmenu'])){
        $result .= __create_add_menu($value['#addmenu']);
    }
    $result .= __create_form_open($value, $key);
    $result .= "\n" . '<fieldset>' . "\n";
    $result .= '<legend>' . __t('Identitas Pasien') . '</legend>' . "\n";
    foreach($value as $ky => $vl){
        if(!eregi('#', $ky)){
            if($vl['#type'] == 'hidden'){
                $result .= '<input type="hidden" name="' . $ky . '" value="' . $vl['#value'] . '">' . "\n";
            }
        }
    }
    $gettbpos = array();
    foreach($value as $ky => $vl){
        if(!eregi('#', $ky)){
            if($ky != 'tab_items'){
                if(isset($vl['#tbpos'])){
                    $gettbpos[$vl['#tbpos']] = $vl;
                    $gettbpos[$vl['#tbpos']]['#key'] = $ky;
                }
            }
        }
    }
    ksort($gettbpos);
    foreach($gettbpos as $ky => $vl){
        if((int)$ky < 1 || (int)$ky % 5 == 0){
            $result .= '<div id="kolom">' . "\n";
            $setdiv = 1;
        }
        $result .= '<label>' . ucwords($vl['#title']) . '</label>';
        if($vl['#type'] != 'textarea'){
            $result .= '<input type="text" value="' . $vl['#value'] .'" readonly="true"> <br />' . "\n";
        } else {
            $result .= '<textarea  readonly="true">' . $vl['#value'] .'</textarea> <br />' . "\n";
        }
        if((int)$ky > 3 && ((int)$ky + 1) % 5 == 0){
            unset($setdiv);
            $result .= '</div>' . "\n";
        }
    } unset($gettbpos);
    if(isset($setdiv)){
        $result .= '</div>' . "\n";
        unset($setdiv);
    }
    $result .= '</fieldset>' . "\n";


//    echo "<pre>";print_r($value);echo "</pre>";
    $result .= '<div>' . "\n";
    $result .= '<table width=100% class="table" border="0">' . "\n";
    foreach($value as $yk => $lv){
        if(!eregi('#', $yk) && is_array($lv) && $yk != 'submit'){
            if($lv['#type'] != 'hidden' && !isset($lv['#tbpos'])){
                if(isset($lv['#customized'])){
                    if(!isset($rowspan[$lv['#customized']['id']])){$rowspan[$lv['#customized']['id']] = array();}
                    $rowspan[$lv['#customized']['id']][] = $yk;
                }
            }
        }
    }
    $cnt = 0;
    foreach($value as $yk => $lv){
        if(!eregi('#', $yk) && is_array($lv) && $yk != 'submit'){
            if($lv['#type'] != 'hidden' && !isset($lv['#tbpos'])){
                $result .= '<tr valign="top">' . "\n";
                $result .= '<td align="right" width="15%">' . ucwords($lv['#title']) . '</td>' . "\n";
                $result .= '<td>';
                if($lv['#type'] == 'select'){
                    if(isset($lv['#readonly']) && trim($lv['#readonly']) !== FALSE){
                        $result .= $lv['#theref'][$lv['#value']];
                    } else {
                        $result .= '<input type="radio" name="' . $yk . '[0]" value="Normal"> Normal <br />';// value="' . $kk . '"' . (isset($lv['#value'][0]) && $lv['#value'][0] == $kk ? ' checked="true"' : '') . '> ' . $vv;
                        $result .= '<input type="radio" name="' . $yk . '[0]" value="Steunosis"> Steunosis ';
                        $result .= '<select name="' . $yk . '[1]" size="1">';
                        $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>';
                        $result .= '<option value="10% - 20%">' . __t('10% - 20%') . '</option>';
                        $result .= '<option value="21% - 30%">' . __t('21% - 30%') . '</option>';
                        $result .= '<option value="31% - 40%">' . __t('31% - 40%') . '</option>';
                        $result .= '<option value="41% - 50%">' . __t('41% - 50%') . '</option>';
                        $result .= '<option value="51% - 60%">' . __t('51% - 60%') . '</option>';
                        $result .= '<option value="61% - 70%">' . __t('61% - 70%') . '</option>';
                        $result .= '<option value="71% - 80%">' . __t('71% - 80%') . '</option>';
                        $result .= '<option value="81% - 90%">' . __t('81% - 90%') . '</option>';
                        $result .= '<option value="91% - 100%">' . __t('91% - 100%') . '</option>';
                        $result .= '</select> ';
                        $result .= '<select name="' . $yk . '[2]" size="1">';
                         $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>';
                        foreach($lv['#theref'] as $kk => $vv){
                            $result .= '<option value="' . $kk . '"' . (isset($lv['#value']) && $lv['#value'] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>';
                        }
                        $result .= '</select>';
                    }
                } else {
                    if(isset($lv['#readonly']) && trim($lv['#readonly']) !== FALSE){
                        $result .= $lv['#value'];
                    } else {
                        $result .= '<select name="' . $yk . '" size="1">';
                         $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>';
                        foreach($lv['#theref'] as $kk => $vv){
                            $result .= '<option value="' . $kk . '"' . (isset($lv['#value']) && $lv['#value'] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>';
                        }
                        $result .= '</select>';
//                        $result .= '<input type="' . $lv['#type'] . '" name="' . $yk . '"' . (isset($lv['#size']) ? ' size="' . $lv['#size'] . '"' : '') . '>';
                    }
                }
                $result .= '</td>' . "\n";

//                if(!isset($lv['#customized'])){
//                    $result .= '<td align="right" width="15%">' . ucwords($lv['#title']) . '</td>' . "\n";
//                    $result .= '<td align="left" colspan="4">';
//                    if($lv['#type'] == 'select'){
//                        if(isset($lv['#readonly']) && trim($lv['#readonly']) !== FALSE){
//                            $result .= $lv['#theref'][$lv['#value']];
//                        } else {
////                            $result .= '<input type="radio" name="' . $yk . '[0]" value="' . $kk . '"' . (isset($lv['#value'][0]) && $lv['#value'][0] == $kk ? ' checked="true"' : '') . '> ' . $vv;
//                            $result .= '<select name="' . $yk . '" size="1">';
//                            $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>';
//                            foreach($lv['#theref'] as $kk => $vv){
//                                $result .= '<option value="' . $kk . '"' . (isset($lv['#value']) && $lv['#value'] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>';
//                            }
//                            $result .= '</select>';
//                        }
//                    } else {
//                        if(isset($lv['#readonly']) && trim($lv['#readonly']) !== FALSE){
//                            $result .= $lv['#value'];
//                        } else {
//                            $result .= '<input type="' . $lv['#type'] . '" name="' . $yk . '"' . (isset($lv['#size']) ? ' size="' . $lv['#size'] . '"' : '') . '>';
//                        }
//                    }
//                    $result .= '</td>' . "\n";
//                } else {
//                    if(!is_array($lv['#value'])){
//                        $lv['#value'] = explode('|', $lv['#value']);
//                    }
//                    if(!isset($dumpt)){$dumpt = array();}
//                    if(!in_array($lv['#customized']['title'], $dumpt)){
//                        $dumpt[] = $lv['#customized']['title'];
//                        $result .= '<td align="right" rowspan="' . count($rowspan[$lv['#customized']['id']]) . '">' . ucwords($lv['#customized']['title']) . '</td>' . "\n";
//                    }
//                    $result .= '<td width="15%" align="' . ($yk != 'gelombang_t' ? 'right' : 'left') . '">';
//                    if($yk != 'gelombang_t'){
//                        $result .= ucwords($lv['#title']);
//                    } else {
//                        if(isset($lv['#readonly']) && $lv['#readonly'] !== FALSE){
//                            $result .= $lv['#value'][0];
//                        } else {
//                            foreach($lv['#customized']['option'] as $kk => $vv){
//                                if(isset($koma)){
//                                    $result .= '<br />';
//                                }
//                                $result .= '<input type="radio" name="' . $yk . '[0]" value="' . $kk . '"' . (isset($lv['#value'][0]) && $lv['#value'][0] == $kk ? ' checked="true"' : '') . '> ' . $vv;
//                                $koma = 0;
//                            } unset($koma);
//                        }
//                    }
//                    $result .= '</td>' . "\n";
//                    $result .= '<td align="left"' . ($lv['#type'] != 'select2' ? ' colspan="2"' : '') . '>';
//                    if($yk != 'gelombang_t'){
//                        if(isset($lv['#readonly']) && $lv['#readonly'] !== FALSE){
//                            $result .= ($lv['#type'] == 'select' ? $lv['#theref'][$lv['#value'][0]] : $lv['#value'][0]) . ($lv['#type'] == 'select' ? '' : ' ' . __t('pada sandapan') . ' ' . $lv['#theref'][$lv['#value'][1]]);
//                        } else {
//                            if($lv['#type'] == 'select2'){
////                                echo '<pre>'; print_r($lv['#value']); echo '</pre>';
//                                $result .= '<select name="' . $yk . '[0]" size="1">';
//                                $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
//                                foreach($lv['#customized']['option'] as $kk => $vv){
//                                    $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][0]) && $lv['#value'][0] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
//                                }
//                                $result .= '</select>' . "\n";
//                            } elseif($lv['#type'] == 'select3') {
//                                $result .= '<select name="' . $yk . '[0]" size="1">';
//                                $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
//                                foreach($lv['#customized']['option'] as $kk => $vv){
//                                    $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][0]) && $lv['#value'][0] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
//                                }
//                                $result .= '</select>' . "\n";
//                                $result .= __t('pada sandapan') . "\n";
//                                $result .= '<select name="' . $yk . '[1]" size="1">';
//                                $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
//                                foreach($lv['#theref'] as $kk => $vv){
//                                    $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][1]) && $lv['#value'][1] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
//                                }
//                                $result .= '</select>' . "\n";
//                            } else {
//                                $result .= '<select name="' . $yk . '[0]" size="1">';
//                                $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
//                                foreach($lv['#theref'] as $kk => $vv){
//                                    $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][0]) && $lv['#value'][0] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
//                                }
//                                $result .= '</select>' . "\n";
//                            }
//                        }
//                    } else {
//                        $result .= '<br />' . __t('pada sandapan') . "\n";
//                        if(isset($lv['#readonly']) && $lv['#readonly'] !== FALSE){
//                            $result .= $lv['#theref'][$lv['#value'][1]];
//                        } else {
//                            $result .= '<select name="' . $yk . '[1]" size="1">' . "\n";
//                            $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
//                            foreach($lv['#theref'] as $kk => $vv){
//                                $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][1]) && $lv['#value'][1] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
//                            }
//                            $result .= '</select>' . "\n";
//                        }
//                    }
//                    $result .= '</td>' . "\n";
//                    if($lv['#type'] == 'select2' && (!isset($lv['#readonly']) || $lv['#readonly'] !== TRUE)){
//                        $result .= '<td align="left">' . "\n";
//                        $result .= __t('pada sandapan') . "\n";
//                        $result .= '<select name="' . $yk . '[1]" size="1">';
//                        $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
//                        foreach($lv['#theref'] as $kk => $vv){
//                            $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][1]) && $lv['#value'][1] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
//                        }
//                        $result .= '</select>' . "\n";
//                        $result .= '</td>';
//                    }
//                }
                $result .= '</tr>' . "\n";
                $cnt++;
            }
        }
    } unset($dumpt, $cnt, $rowspan);
    $result .= '</table>' . "\n";
    $result .= '</div>' . "\n";

    if(isset($value['submit'])){
        $result .= '<div>' . "\n";
        $result .= '<input type="submit" value="' . $value['submit']['#value'] . '"' . (isset($value['submit']['#extra']) ? ' ' . $value['submit']['#extra'] : '') . '>';
        $result .= '</div>' . "\n";
    }
    $result .= __create_form_close();
//    $result .= '<script type="text/javascript">' . "\n";
//    $result .= 'var tabs=new ddtabcontent("fisistabs")' . "\n";
//    $result .= 'tabs.setpersist(true)' . "\n";
//    $result .= 'tabs.setselectedClassTarget("link") //"link" or "linkparent"' . "\n";
//    $result .= 'tabs.init()' . "\n";
//    $result .= '</script>' . "\n";
}
