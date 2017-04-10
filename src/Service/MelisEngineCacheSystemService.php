<?php

/**
 * Melis Technology (http://www.melistechnology.com)
 *
 * @copyright Copyright (c) 2017 Melis Technology (http://www.melistechnology.com)
 *
 */

namespace MelisEngine\Service;

use Zend\ServiceManager\ServiceLocatorAwareInterface;
use Zend\ServiceManager\ServiceLocatorInterface;
use MelisEngine\Model\MelisPage;
use Zend\Filter\HtmlEntities;
use Zend\Cache\StorageFactory;

/**
 * This class handles MelisCache based on Zend Cache Storage configurations
 * See module.config.php, "caches" keys for overridding config for your own site
 *
 */
class MelisEngineCacheSystemService implements ServiceLocatorAwareInterface
{
	protected $serviceLocator;
	
	public function setServiceLocator(ServiceLocatorInterface $sl)
	{
		$this->serviceLocator = $sl;
		return $this;
	}
	
	public function getServiceLocator()
	{
		return $this->serviceLocator;
	}	

    /**
     * Returns front/melis
     * 
     * @return string
     */
	public function getRenderMode()
	{
	    $router = $this->serviceLocator->get('router');
	    $request = $this->serviceLocator->get('request');
	
	    $routeMatch = $router->match($request);
	    
	    if (!empty($routeMatch))
	       $renderMode = $routeMatch->getParam('renderMode', 'melis');
	    else
	        $renderMode = 'melis'; // no cache
	
	    return $renderMode;
	}
	
	/**
	 * Returns if cache is active or not for this conf
	 * 
	 * @param string $confCache
	 * @return boolean
	 */
	public function isCacheConfActive($confCache)
	{
	    $active = true;
	    
	    $config =  $this->getServiceLocator()->get('config');
	    if (!empty($config['caches']) && !empty($config['caches'][$confCache]))
	    {
	        $conf = $config['caches'][$confCache];
	        
	        if (isset($conf['active']))
	            $active = $conf['active'];
	    }
	    
	    return $active;
	}
	
	/**
	 * Returns the duration of cache, default or specific is a ttl key 
	 * is found in conf for this cache key
	 * 
	 * @param string $confCache
	 * @param string $cacheKey
	 * @return int
	 */
	public function getTtlByKey($confCache, $cacheKey)
	{
	    $ttl = 0;
	    $config =  $this->getServiceLocator()->get('config');
	    if (!empty($config['caches']) && !empty($config['caches'][$confCache]))
	    {
	        $conf = $config['caches'][$confCache];
	         
	        // Get default ttl from adapater config
	        if (!empty($conf['adapter']['options']['ttl']))
	            $ttl = $conf['adapter']['options']['ttl'];
	        
	        foreach ($conf['ttls'] as $nameKey => $tll)
	        {
	            preg_match("/$nameKey/", $cacheKey, $matches, PREG_OFFSET_CAPTURE, 3);
	            
	            if (count($matches) > 0)
	            {
	                $ttl = $conf['ttls'][$nameKey];
	                break;
	            }
	        }
	    }
	    
	    return $ttl;
	}
	
	/**
	 * Gets the cache for this key/conf
	 * 
	 * @param string $cacheKey
	 * @param string $confCache
	 * @return mixed
	 */
	public function getCacheByKey($cacheKey, $confCache)
	{
	    // only when in front mode
	    if ($this->getRenderMode() != 'front')
	        return null;
	    
	//    $ttl = $this->getTtlByKey($confCache, $cacheKey);
	    $active = $this->isCacheConfActive($confCache);
	    if ($active)
	    {
	        $cache = $this->getServiceLocator()->get($confCache);
	    //    $cache->getOptions()->setTtl($ttl);

	    //    $config =  $this->getServiceLocator()->get('config');
	    //    $cache = StorageFactory::factory($config['caches'][$confCache]);
	    //    $cache->getOptions()->setTtl($ttl);
	       
	        if ($cache->hasItem($cacheKey))
	        {
	            $itemValue = $cache->getItem($cacheKey);
	    //        unset($cache);
	            return $itemValue;
	        }
	    }
	    
	    return null;
	}
	
	/**
	 * Sets the cache for this key/conf
	 * 
	 * @param string $cacheKey
	 * @param string $confCache
	 * @param mixed $results
	 * @return void
	 */
	public function setCacheByKey($cacheKey, $confCache, $results)
	{
	    if ($this->getRenderMode() != 'front')
	        return;

	//    $ttl = $this->getTtlByKey($confCache, $cacheKey);
	    $active = $this->isCacheConfActive($confCache);
	    if ($active)
	    {
	        $cache = $this->getServiceLocator()->get($confCache);
	     //   $cache->setOptions(array('ttl' => $ttl));
	    

	   //     $config =  $this->getServiceLocator()->get('config');
	   //    $cache = StorageFactory::factory($config['caches'][$confCache]); 
	        
	        $cache->setItem($cacheKey, $results);
	        unset($cache);
	    }
	}
	
	/**
	 * Clears cache by the prefix, cachekey first part
	 * 
	 * @param string $prefix
	 * @param string $confName
	 */
	public function deleteCacheByPrefix($prefix, $confName)
	{
	    $this->getServiceLocator()->get($confName)->clearByPrefix($prefix);
	}
	
}