<?php
/**
 * Random String Task
 *
 * @category    Kirchbergerknorr
 * @package     Kirchbergerknorr
 * @author      Aleksey Razbakov <ar@kirchbergerknorr.de>
 * @copyright   Copyright (c) 2015 kirchbergerknorr GmbH (http://www.kirchbergerknorr.de)
 * @license     http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 */

require_once 'phing/Task.php';

class RandomStringTask extends Task
{
    private $propertyName;

    /**
     * Set the name of the property to set.
     * @param string $v Property name
     * @return void
     */
    public function setPropertyName($v) {
        $this->propertyName = $v;
    }


    public function main() {
        if (!$this->propertyName) {
            throw new BuildException("You must specify the propertyName attribute", $this->getLocation());
        }

        $project = $this->getProject();

        $c = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxwz0123456789";
        $length = 12;
        $s = '';
        for(;$length > 0;$length--) $s .= $c{rand(0,strlen($c))};
        $random = str_shuffle($s);
        $this->project->setProperty($this->propertyName, $random);
    }
}