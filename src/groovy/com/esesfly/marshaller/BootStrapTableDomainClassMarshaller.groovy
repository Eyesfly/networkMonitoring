package com.esesfly.marshaller

import grails.converters.JSON
import org.codehaus.groovy.grails.commons.DomainClassArtefactHandler
import org.codehaus.groovy.grails.commons.GrailsApplication
import org.codehaus.groovy.grails.commons.GrailsDomainClass
import org.codehaus.groovy.grails.commons.GrailsDomainClassProperty
import org.codehaus.groovy.grails.support.IncludeExcludeSupport
import org.codehaus.groovy.grails.support.proxy.EntityProxyHandler
import org.codehaus.groovy.grails.support.proxy.ProxyHandler
import org.codehaus.groovy.grails.web.converters.ConverterUtil
import org.codehaus.groovy.grails.web.converters.configuration.ConvertersConfigurationHolder
import org.codehaus.groovy.grails.web.converters.exceptions.ConverterException
import org.codehaus.groovy.grails.web.converters.marshaller.json.DomainClassMarshaller
import org.codehaus.groovy.grails.web.json.JSONWriter
import org.springframework.beans.BeanWrapper
import org.springframework.beans.BeanWrapperImpl

/**
 *  作成日期：2017/2/13 18:00
 *  <p>功能描述：</p>
 * @author: chenliyuan
 * @version: 0.1
 */
class BootStrapTableDomainClassMarshaller extends DomainClassMarshaller {
    private GrailsApplication referApplication;
    public BootStrapTableDomainClassMarshaller(boolean includeVersion, GrailsApplication application) {
        super(includeVersion, application);
        this.referApplication=application;
    }

    public BootStrapTableDomainClassMarshaller(boolean includeVersion, ProxyHandler proxyHandler, GrailsApplication application) {
        super(includeVersion, proxyHandler, application);
    }
    @Override
    protected void asShortObject(Object refObj, JSON json, GrailsDomainClassProperty idProperty, GrailsDomainClass referencedDomainClass) throws ConverterException {

        Object idValue;
        ProxyHandler proxyHandler=ConvertersConfigurationHolder.getConverterConfiguration(JSON.class).proxyHandler
        if (proxyHandler instanceof EntityProxyHandler) {
            idValue = ((EntityProxyHandler) proxyHandler).getProxyIdentifier(refObj);
            if (idValue == null) {
                idValue = extractValue(refObj, idProperty);
            }
        }
        else {
            idValue = extractValue(refObj, idProperty);
        }
        JSONWriter writer = json.getWriter();
        writer.object();
        writer.key("class").value(referencedDomainClass.getFullName());
        writer.key("title").value(refObj.toString());
        writer.key("id").value(idValue);
        writer.endObject();
    }
    @Override
    public void marshalObject(Object value, JSON json) throws ConverterException {
        GrailsApplication application=referApplication;
        ProxyHandler proxyHandler=ConvertersConfigurationHolder.getConverterConfiguration(JSON.class).proxyHandler
        JSONWriter writer = json.getWriter();
        value = proxyHandler.unwrapIfProxy(value);
        Class<?> clazz = value.getClass();

        List<String> excludes = json.getExcludes(clazz);
        List<String> includes = json.getIncludes(clazz);
        IncludeExcludeSupport<String> includeExcludeSupport = new IncludeExcludeSupport<String>();

        GrailsDomainClass domainClass = (GrailsDomainClass)application.getArtefact(
                DomainClassArtefactHandler.TYPE, ConverterUtil.trimProxySuffix(clazz.getName()));
        BeanWrapper beanWrapper = new BeanWrapperImpl(value);

        writer.object();

        if(shouldInclude(includeExcludeSupport, includes, excludes, value, "class")) {
            writer.key("class").value(domainClass.getClazz().getName());
        }


        GrailsDomainClassProperty id = domainClass.getIdentifier();

        if(shouldInclude(includeExcludeSupport, includes, excludes, value, id.getName())) {
            Object idValue = extractValue(value, id);
            json.property(GrailsDomainClassProperty.IDENTITY, idValue);
        }

        if (shouldInclude(includeExcludeSupport, includes, excludes, value, GrailsDomainClassProperty.VERSION) && isIncludeVersion()) {
            GrailsDomainClassProperty versionProperty = domainClass.getVersion();
            Object version = extractValue(value, versionProperty);
            json.property(GrailsDomainClassProperty.VERSION, version);
        }

        GrailsDomainClassProperty[] properties = domainClass.getPersistentProperties();

        //commont to aviod byte[]
        //add by xp
        properties=properties.findAll{it.type!=byte[]}
        //end
        for (GrailsDomainClassProperty property : properties) {
            if(!shouldInclude(includeExcludeSupport, includes, excludes, value, property.getName())) continue;

            writer.key(property.getName());
            if (!property.isAssociation()) {
                // Write non-relation property
                Object val = beanWrapper.getPropertyValue(property.getName());
                json.convertAnother(val);
            }
            else {
                Object referenceObject = beanWrapper.getPropertyValue(property.getName());
                if (isRenderDomainClassRelations()) {
                    if (referenceObject == null) {
                        writer.valueNull();
                    }
                    else {
                        referenceObject = proxyHandler.unwrapIfProxy(referenceObject);
                        if (referenceObject instanceof SortedMap) {
                            referenceObject = new TreeMap((SortedMap) referenceObject);
                        }
                        else if (referenceObject instanceof SortedSet) {
                            referenceObject = new TreeSet((SortedSet) referenceObject);
                        }
                        else if (referenceObject instanceof Set) {
                            referenceObject = new HashSet((Set) referenceObject);
                        }
                        else if (referenceObject instanceof Map) {
                            referenceObject = new HashMap((Map) referenceObject);
                        }
                        else if (referenceObject instanceof Collection) {
                            referenceObject = new ArrayList((Collection) referenceObject);
                        }
                        json.convertAnother(referenceObject);
                    }
                }
                else {
                    if (referenceObject == null) {
                        json.value(null);
                    }
                    else {
                        GrailsDomainClass referencedDomainClass = property.getReferencedDomainClass();

                        // Embedded are now always fully rendered
                        if (referencedDomainClass == null || property.isEmbedded() || property.getType().isEnum()) {
                            json.convertAnother(referenceObject);
                        }
                        else if (property.isOneToOne() || property.isManyToOne() || property.isEmbedded()) {
                            asShortObject(referenceObject, json, referencedDomainClass.getIdentifier(), referencedDomainClass);
//                            writer.key("${referencedDomainClass.getPropertyName()}.text").value(referenceObject.toString());
                        }
                        else {
                            GrailsDomainClassProperty referencedIdProperty = referencedDomainClass.getIdentifier();
                            @SuppressWarnings("unused")
                            String refPropertyName = referencedDomainClass.getPropertyName();
                            if (referenceObject instanceof Collection) {
                                Collection o = (Collection) referenceObject;
                                writer.array();
                                for (Object el : o) {
                                    asShortObject(el, json, referencedIdProperty, referencedDomainClass);
                                }
                                writer.endArray();
                            }
                            else if (referenceObject instanceof Map) {
                                Map<Object, Object> map = (Map<Object, Object>) referenceObject;
                                for (Map.Entry<Object, Object> entry : map.entrySet()) {
                                    String key = String.valueOf(entry.getKey());
                                    Object o = entry.getValue();
                                    writer.object();
                                    writer.key(key);
                                    asShortObject(o, json, referencedIdProperty, referencedDomainClass);
                                    writer.endObject();
                                }
                            }
                        }
                    }
                }
            }
        }
        writer.endObject();
    }

}
