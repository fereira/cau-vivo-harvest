  <!--
    Copyright (c) 2010-2011 VIVO Harvester Team. For full list of
    contributors, please see the AUTHORS file provided. All rights
    reserved. This program and the accompanying materials are made
    available under the terms of the new BSD license which accompanies
    this distribution, and is available at
    http://www.opensource.org/licenses/bsd-license.html
  -->
  <!-- <?xml version="1.0"?> -->
  <!--
    Header information for the Style Sheet The style sheet requires xmlns
    for each prefix you use in constructing the new elements
  -->
<xsl:stylesheet version="2.0"
    xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs = "http://www.w3.org/2000/01/rdf-schema#"
    xmlns:vivo = "http://vivoweb.org/ontology/core#" 
    xmlns:score = "http://vivoweb.org/ontology/score#"
    xmlns:foaf = "http://xmlns.com/foaf/0.1/"
    xmlns:bibo = "http://purl.org/ontology/bibo/"
    xmlns:obo = "http://purl.obolibrary.org/obo/"
    xmlns:vitro = "http://vitro.mannlib.cornell.edu/ns/vitro/0.7#"
    xmlns:vcard = "http://www.w3.org/2006/vcard/ns#"
    xmlns:geo = "http://aims.fao.org/aos/geopolitical.owl#"
    xmlns:db-vivotest="jdbc:mysql://localhost/caudata/fields/vivotest/"
    xmlns:localVivo = "http://vivo.sample.edu/ontology/"
    xmlns:agrivivo = "http://www.agrivivo.net/ontology/agrivivo#"    
    xmlns:parseArticle = "java:edu.cornell.mannlib.harvester.xslt.ParseArticle"
    extension-element-prefixes = "parseArticle"
  >

  <!-- This will create indenting in xml readers -->
  <xsl:output method="xml" indent="yes" />
  <xsl:variable name="baseURI">http://vivo.example.com/harvest/</xsl:variable>

  <!--
    The main node of the record loaded This serves as the header of the
    RDF file produced
  -->
  <xsl:template match="rdf:RDF">
    <rdf:RDF xmlns:rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:rdfs = "http://www.w3.org/2000/01/rdf-schema#"
            xmlns:vivo = "http://vivoweb.org/ontology/core#"
            xmlns:score = "http://vivoweb.org/ontology/score#"
            xmlns:foaf = "http://xmlns.com/foaf/0.1/"
            xmlns:bibo = "http://purl.org/ontology/bibo/">
      <xsl:apply-templates select="rdf:Description" />
    </rdf:RDF>
  </xsl:template>

  <!-- Here are the fields: 
NUMBER, ORCID, NAME, SEX, PHOTO, POSITION, DAOSHITYPE, YUANSHI1, YUANSHI2, XUEWEI, XUEKE, ZHUANYE, FANAXIANG, UNIVERSITY, A1, A2, PROJECT, BOOKS, ARTICLE, CURSE, WEBSITE, ADDRESS, PHONE, EMAIL
   -->
   

  
  <xsl:template match = "rdf:Description">
    <xsl:variable name = "this" select = "." />
    <xsl:call-template name = "t_People">
      <xsl:with-param name = "this" select = "$this" />
      <xsl:with-param name = "personid" select = "$this/db-vivotest:number" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="t_People"
     xmlns:parseArticle = "java:edu.cornell.mannlib.harvester.xslt.ParseArticle"
     extension-element-prefixes = "parseArticle"    
  >
    <xsl:param name = 'personid' />
    <xsl:param name = 'this' />

    <xsl:variable name="orcid" select = "$this/db-vivotest:orcid" />
    <xsl:variable name="name" select="$this/db-vivotest:name"/>
    <xsl:variable name="sex" select="$this/db-vivotest:sex"/>    
    <xsl:variable name="photo" select="$this/db-vivotest:photo" />
    <xsl:variable name="position" select = "$this/db-vivotest:position" />
    <xsl:variable name="daoshitype" select = "$this/db-vivotest:daoshitype" />
    <xsl:variable name="yuanshi1" select = "$this/db-vivotest:yuanshi1" />
    <xsl:variable name="yuanshi2" select = "$this/db-vivotest:yuanshi2" />
    <xsl:variable name="education" select = "$this/db-vivotest:xuewei" /> 
    <xsl:variable name="concept" select="$this/db-vivotest:xueke"/> <!-- subject -->
    <xsl:variable name="zhuanye" select="$this/db-vivotest:zhuanye"/> <!-- subject -->
    <xsl:variable name="fangxiang" select="$this/db-vivotest:fangxiang"/> <!-- research overview -->
    <xsl:variable name="university" select="normalize-space($this/db-vivotest:university)"/>
    <xsl:variable name="universityID" select="encode-for-uri($university)"/>
    <xsl:variable name="college" select="normalize-space($this/db-vivotest:xueyuan)"/>
    <xsl:variable name="collegeID" select="encode-for-uri($college)"/>
    <xsl:variable name="a1" select="$this/db-vivotest:a1"/>
    <xsl:variable name="a2" select="$this/db-vivotest:a2"/>
    <xsl:variable name="projects" select="$this/db-vivotest:project"/>
    <xsl:variable name="books" select="$this/db-vivotest:books"/>
    <xsl:variable name="articles" select="$this/db-vivotest:article"/>
    <xsl:variable name="curse" select="$this/db-vivotest:curse"/>
    <xsl:variable name="website" select="$this/db-vivotest:website"/>
    <xsl:variable name="address" select="$this/db-vivotest:address"/>
    <xsl:variable name="phone" select="$this/db-vivotest:phone"/>
    <xsl:variable name="email" select="$this/db-vivotest:email"/>

    <xsl:variable name="rolename">
      <xsl:choose>
         <xsl:when test="normalize-space( $this/db-vivotest:position )">
	 <xsl:value-of select="$this/db-vivotest:position" />
	 </xsl:when>
	 <xsl:otherwise>Affiliate</xsl:otherwise>
	 </xsl:choose>
    </xsl:variable>
 
    <xsl:variable name="roleid">
      <xsl:choose>
         <xsl:when test="normalize-space( $this/db-vivotest:position )">
	 <xsl:value-of select="encode-for-uri($this/db-vivotest:position)" />
	 </xsl:when>
	 <xsl:otherwise>Affiliate</xsl:otherwise>
	 </xsl:choose>
    </xsl:variable>
    
    <xsl:text>
     
    </xsl:text> 
    <xsl:comment> 
    </xsl:comment>
    <xsl:text>
     
    </xsl:text> 
    
  <!-- Here are the fields: 
NUMBER, ORCID, NAME, SEX, PHOTO, POSITION, DAOSHITYPE, YUANSHI1, YUANSHI2, XUEWEI, XUEKE, ZHUANYE, FANAXIANG, UNIVERSITY, A1, A2, PROJECT, BOOKS, ARTICLE, CURSE, WEBSITE, ADDRESS, PHONE, EMAIL
   -->

    <!-- Person -->
    <rdf:Description rdf:about="{$baseURI}person/person{$personid}">

      <localVivo:harvestedBy>CAU Harvester</localVivo:harvestedBy>      
      <rdf:type rdf:resource = "http://xmlns.com/foaf/0.1/Person"/>
      <vitro:mostSpecificType rdf:resource="http://xmlns.com/foaf/0.1/Person"/>
      <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$name" /></rdfs:label>
      <localVivo:personID rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select="$personid" /></localVivo:personID> 
       
      <score:email><xsl:value-of select= "$email" /></score:email>
      <score:name><xsl:value-of select= "$name" /></score:name> 
      <vivo:overview><xsl:value-of select= "$sex" /><xsl:value-of select= "$education" /><xsl:value-of select= "$daoshitype" /> </vivo:overview>
     
  
      <obo:ARG_2000028 rdf:resource="{$baseURI}vcard/vcardFor{$personid}"/>
      
      <!--
      <xsl:if test="normalize-space( $geolocation )">
         <obo:RO_0001025 rdf:resource="{$geolocation}"/>
         <vivo:hasGeographicLocation rdf:resource="{$geolocation}" />
      </xsl:if>
      -->

      
      <xsl:if test="($universityID !='') and ($roleid!='')" >
      <vivo:relatedBy rdf:resource="{$baseURI}position/positionFor{$universityID }-{$roleid}"/>
      </xsl:if> 
      
      <xsl:if test="normalize-space( $photo )">
         <localVivo:photo><xsl:value-of select="$photo" /></localVivo:photo>
      </xsl:if>
      
      <!--  
      <xsl:if test="normalize-space( $articles )">
	    <xsl:call-template name="articles">
		<xsl:with-param name="list" select="$articles"/>
	   </xsl:call-template>
      </xsl:if> 
      -->
      
      <xsl:if test="normalize-space( $projects )">
	    <xsl:apply-templates select="$projects" mode="projectRef" />
      </xsl:if> 
      
      <!-- add hasResearchArea -->
      <xsl:if test="normalize-space( $concept )">
	     <xsl:call-template name="researchAreaRef">
		<xsl:with-param name="list" select="$concept"/>
	   </xsl:call-template>   
      </xsl:if>
      
      <xsl:if test="normalize-space( $zhuanye )">
	     <xsl:call-template name="researchAreaRef">
		<xsl:with-param name="list" select="$zhuanye"/>
	   </xsl:call-template>   
      </xsl:if>
      
      <!-- link to authorship -->
      <xsl:if test="normalize-space( $articles )">
         <xsl:call-template name="authorshipRef">
		 <xsl:with-param name="list" select="$articles"/>
		 <xsl:with-param name="localPersonID" select="$personid" />
	     </xsl:call-template>    
      </xsl:if>
       
    </rdf:Description>
    
    <!-- vcard for person -->
     <rdf:Description rdf:about="{$baseURI}vcard/vcardFor{$personid}"> 
       <vcard:hasName rdf:resource="{$baseURI}vcardName/vcardNameFor{$personid}"/>

       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#Individual"/>
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Kind"/>
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Individual"/>
       <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
       <rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000031"/>
       <rdf:type rdf:resource="http://purl.obolibrary.org/obo/ARG_2000379"/>
       <rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000002"/>
       <rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000001"/>
       <rdf:type rdf:resource="http://purl.obolibrary.org/obo/IAO_0000030"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard for: <xsl:value-of select = "$name" /></rdfs:label>
       <vcard:hasEmail rdf:resource="{$baseURI}vcardEmail/vcardEmailFor{$personid}"/>
       <xsl:if test="normalize-space( $website )">
       <vcard:hasURL rdf:resource="{$baseURI}vcardUrl/vcardUrlFor{$personid}"/>
       </xsl:if>

       <xsl:if test="normalize-space( $address )">
       <vcard:hasAddress rdf:resource="{$baseURI}vcardAddress/vcardAddressFor{$personid}"/>
       </xsl:if>

       <xsl:if test="normalize-space( $phone )">
       <vcard:hasTelephone rdf:resource="{$baseURI}vcardPhone/vcardPhoneFor{$personid}"/>
       </xsl:if>

       <xsl:if test="normalize-space( $rolename )">
       <vcard:hasTitle rdf:resource="{$baseURI}vcardTitle/vcardTitleFor{$personid}"/>
       </xsl:if>

       <xsl:if test="normalize-space($concept)">
              <xsl:call-template name="subjectAreaRef">
              <xsl:with-param name="list" select="$concept" />
              </xsl:call-template>        
       </xsl:if>
       
       <xsl:if test="normalize-space($zhuanye)">
              <xsl:call-template name="subjectAreaRef">
              <xsl:with-param name="list" select="$zhuanye" />
              </xsl:call-template>        
       </xsl:if>
       
       <obo:ARG_2000029 rdf:resource="{$baseURI}person/person{$personid}"/> 
       
     </rdf:Description>
     
     <!-- vcard name -->
     <rdf:Description rdf:about="{$baseURI}vcardName/vcardNameFor{$personid}">
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Name"/> 
       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#Name"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard name for: <xsl:value-of select = "$name" /></rdfs:label>
       <vcard:givenName rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$name" /></vcard:givenName>     
       <!--
       <vcard:familyName rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$lastName" /></vcard:familyName>
      -->
     </rdf:Description>
     
     <!-- vcard email -->
     <rdf:Description rdf:about="{$baseURI}vcardEmail/vcardEmailFor{$personid}">
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Email"/>
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Work"/>
       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#Email"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard email for: <xsl:value-of select = "$name" /></rdfs:label>
       <vcard:email rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$email" /></vcard:email>  
     </rdf:Description>
     
     <!-- vcard title -->
     <xsl:if test="normalize-space( $rolename )">
     <rdf:Description rdf:about="{$baseURI}vcardTitle/vcardTitleFor{$personid}">
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Title"/>
       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#Title"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard title for: <xsl:value-of select = "$name" /></rdfs:label>
       <vcard:title rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$rolename" /></vcard:title>  
     </rdf:Description>
     </xsl:if>
     
     <!--  vcard person url -->
     <xsl:if test="normalize-space( $website )">
     <rdf:Description rdf:about="{$baseURI}vcardUrl/vcardUrlFor{$personid}"> 
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#URL"/> 
       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#URL"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard url for: <xsl:value-of select = "$name" /></rdfs:label>
       <vcard:url><xsl:value-of select = "$website" /></vcard:url>     
       <rdfs:label>Website</rdfs:label>
       <vivo:rank rdf:datatype="http://www.w3.org/2001/XMLSchema#int">1</vivo:rank>     
     </rdf:Description>
     </xsl:if>

     <!-- vcard address -->
     <rdf:Description rdf:about="{$baseURI}vcardAddress/vcardAddressFor{$personid}">
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Geo"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard Address for: <xsl:value-of select = "$name" /></rdfs:label>
       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#Address"/>

       <vcard:streetAddress rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$address" /></vcard:streetAddress>
       <!--      
       <vcard:postalCode rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$zipcode" /></vcard:postalCode>
       <vcard:locality rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$city" /></vcard:locality>

       -->
     </rdf:Description> 
     
     <!-- vcard phone -->
     <rdf:Description rdf:about="{$baseURI}vcardPhone/vcardPhoneFor{$personid}">
       <rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Telephone"/>
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string">vCard Phone for: <xsl:value-of select = "$name" /></rdfs:label>
       <vitro:mostSpecificType rdf:resource="http://www.w3.org/2006/vcard/ns#Telephone"/>
       <vcard:telephone rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$phone" /></vcard:telephone>
     </rdf:Description> 
     
     <!-- position in university -->
     <xsl:if test="($universityID !='') and ($roleid!='')" >
     <rdf:Description rdf:about="{$baseURI}position/positionFor{$universityID }-{$roleid}" >
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#Relationship"/>
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#Position"/>
        <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$rolename" /></rdfs:label>
        <score:position><xsl:value-of select= "$rolename" /></score:position>
        <score:university><xsl:value-of select = "$university" /></score:university>

        <vivo:relates rdf:resource="{$baseURI}person/person{$personid}" />
        <vivo:relates rdf:resource="{$baseURI}org/{$universityID }" />

     </rdf:Description>
     </xsl:if> 

     <!--  Organization for University -->
     <xsl:if test="normalize-space( $universityID  )">
     <rdf:Description rdf:about="{$baseURI}org/{$universityID }">
        <localVivo:harvestedBy>CAU Harvester</localVivo:harvestedBy>      
        <rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Organization"/>
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#University"/>
        <vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#University" />
        <xsl:if test="normalize-space( $roleid )">
        <vivo:relatedBy rdf:resource="{$baseURI}position/positionFor{$universityID }-{$roleid}" />
        </xsl:if>
        <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$university" /></rdfs:label>
        <score:university><xsl:value-of select = "$university" /></score:university>
        <obo:BFO_0000051 rdf:resource="{$baseURI}org/{$collegeID}" /> 
     </rdf:Description>
     </xsl:if> 

     <!--  Organization for College -->
     <xsl:if test="normalize-space( $collegeID  )">
     <rdf:Description rdf:about="{$baseURI}org/{$collegeID }">
        <localVivo:harvestedBy>CAU Harvester</localVivo:harvestedBy>      
        <rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Organization"/>
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#College"/>
        <vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#College" />
         
        <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select = "$college" /></rdfs:label>
        <score:college><xsl:value-of select = "$college" /></score:college>
        <obo:BFO_0000050 rdf:resource="{$baseURI}org/{$universityID}" />
     </rdf:Description>
     </xsl:if>
     
     <xsl:if test="normalize-space( $projects )">
	    <xsl:apply-templates select="$this/db-vivotest:project" mode="projectFull" />
     </xsl:if> 
     
     <xsl:if test="normalize-space( $concept )">
	    <xsl:call-template name="concepts">
              <xsl:with-param name="list" select="$concept" />
              <xsl:with-param name="localPersonID" select="$personid" />
        </xsl:call-template>
     </xsl:if>
     
     <xsl:if test="normalize-space( $zhuanye )">
	    <xsl:call-template name="concepts">
              <xsl:with-param name="list" select="$zhuanye" />
              <xsl:with-param name="localPersonID" select="$personid" />
        </xsl:call-template>
     </xsl:if>
     
     <!-- article reference...links authorship to pub -->
     <xsl:if test="normalize-space( $articles )">
	    <xsl:call-template name="articlesRef">
              <xsl:with-param name="list" select="$articles" />
              <xsl:with-param name="localPersonID" select="$personid" />
        </xsl:call-template>
     </xsl:if>
     
     <xsl:if test="normalize-space( $articles )">
	    <xsl:call-template name="articlesFull">
              <xsl:with-param name="list" select="$articles" />
              <xsl:with-param name="localPersonID" select="$personid" />
        </xsl:call-template>
     </xsl:if>
     
 
  </xsl:template> 
  
  <!-- ResearchArea templates -->
   
  
  <xsl:template name="subjectAreaRef">
  <xsl:param name='list' /> 
  <xsl:variable name="subjects" select="tokenize($list,';')" />
  <xsl:for-each select="$subjects">
     <xsl:variable name = "termEncoded" select="encode-for-uri(.)"/> 
     <vivo:hasSubjectArea rdf:resource="{$baseURI}concept/{$termEncoded}"/>
  </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="researchAreaRef">
  <xsl:param name='list' /> 
  <xsl:variable name="subjects" select="tokenize($list,';')" />
  <xsl:for-each select="$subjects">
     <xsl:variable name = "termEncoded" select="encode-for-uri(.)"/> 
     <vivo:hasResearchArea rdf:resource="{$baseURI}concept/{$termEncoded}"/>
  </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="concepts">
  <xsl:param name='list' />
  <xsl:param name="localPersonID" /> 
  <xsl:variable name="subjects" select="tokenize($list,';')" />
  <xsl:for-each select="$subjects">
  <xsl:variable name = "term" select="."/>
  <xsl:variable name = "termEncoded" select="encode-for-uri(.)"/>
  <rdf:Description rdf:about="{$baseURI}concept/{$termEncoded}">
       <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/> 
       <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select="$term"/></rdfs:label>
       <vivo:researchAreaOf rdf:resource="{$baseURI}person/person{$localPersonID}" /> 
       <vivo:subjectAreaOf rdf:resource="{$baseURI}person/person{$localPersonID}" /> 
  </rdf:Description>    
  </xsl:for-each>
  </xsl:template> 
     
  <!-- Project templates -->
  
  <xsl:template match="db-vivotest:project" mode="projectRef">
  <xsl:call-template name="projectRef">
		<xsl:with-param name="list" select="."/>
  </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="db-vivotest:project" mode="projectFull">
  <xsl:call-template name="projectFull">
		<xsl:with-param name="list" select="."/>
  </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="projectRef">
     <xsl:param name='list' />
     <xsl:if test="contains($list, ';')">
         <xsl:variable name="project"><xsl:value-of select="substring-before($list, ';')"/></xsl:variable>
         <xsl:variable name="projectTokens" select="tokenize($project,'\|')" />
         <xsl:variable name="projectName"><xsl:value-of select="$projectTokens[1]"/></xsl:variable>
         <xsl:variable name="projectDesc"><xsl:value-of select="$projectTokens[2]"/></xsl:variable>
         <xsl:variable name="projectRole"><xsl:value-of select="$projectTokens[3]"/></xsl:variable>
         <xsl:variable name="projectDate"><xsl:value-of select="$projectTokens[4]"/></xsl:variable>
         <xsl:variable name="localPersonID"><xsl:value-of select="../db-vivotest:number" /></xsl:variable> 
         <xsl:variable name="projectUri"><xsl:value-of select="encode-for-uri($projectName)"/></xsl:variable>          
         <obo:RO_0000053 rdf:resource="{$baseURI}projectRole/project{$projectUri}For{$localPersonID}" />         
         <xsl:call-template name="projectRef">
            <xsl:with-param name="list" select="substring-after($list, ';')"/>
        </xsl:call-template>
     </xsl:if>        
  </xsl:template>
  
  <xsl:template name="projectFull">
     <xsl:param name='list' />
     <xsl:if test="contains($list, ';')">
     <xsl:variable name="project"><xsl:value-of select="substring-before($list, ';')"/></xsl:variable>
     <xsl:variable name="projectTokens" select="tokenize($project,'\|')" />
     <xsl:variable name="projectName"><xsl:value-of select="$projectTokens[1]"/></xsl:variable>
     <xsl:variable name="projectDesc"><xsl:value-of select="$projectTokens[2]"/></xsl:variable>
     <xsl:variable name="projectRole"><xsl:value-of select="$projectTokens[3]"/></xsl:variable>
     <xsl:variable name="projectDate"><xsl:value-of select="$projectTokens[4]"/></xsl:variable>
     <xsl:variable name="localPersonID"><xsl:value-of select="../db-vivotest:number" /></xsl:variable> 
     <xsl:variable name="projectUri"><xsl:value-of select="encode-for-uri($projectName)"/></xsl:variable>
     <rdf:Description rdf:about="{$baseURI}projectRole/project{$projectUri}For{$localPersonID}">
        <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
        <rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000017"/>
        <rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000002"/>
        <rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000001"/>
        <rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000023"/>
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#ResearcherRole"/>
        <rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000020"/>
        <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select="$projectRole"/></rdfs:label>
        <obo:RO_0000052 rdf:resource="{$baseURI}person/person{$localPersonID}"/>
     </rdf:Description>
     
     <rdf:Description rdf:about="{$baseURI}project/project{$projectUri}For{$localPersonID}">
        <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing" />
        <rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000001" />
        <rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000015" />
        <rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000003" />
        <rdf:type rdf:resource="http://vivoweb.org/ontology/core#Project" />
        <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select="$projectName"/></rdfs:label>
        <obo:BFO_0000055 rdf:resource="{$baseURI}projectRole/project{$projectUri}For{$localPersonID}" />
        <vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#Project" />
        <vivo:description><xsl:value-of select="$projectDesc"/></vivo:description>
       
     </rdf:Description>
     <xsl:call-template name="projectFull">
         <xsl:with-param name="list" select="substring-after($list, ';')"/>
     </xsl:call-template>
     </xsl:if>        
  </xsl:template>
   
  <!-- article templates -->
  <xsl:template name="authorshipRef">
  <xsl:param name='list' />
  <xsl:param name="localPersonID" />
   
  <xsl:variable name="articles" select="tokenize($list,';')" />
  <xsl:for-each select="$articles">
     <xsl:variable name = "articleID"><xsl:value-of select="position()" /></xsl:variable>
     <vivo:relatedBy rdf:resource="{$baseURI}authorship/caupub-article{$articleID}-person{$localPersonID}" /> 
  </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="articlesRef">
  <xsl:param name='list' />
  <xsl:param name="localPersonID" />
  <xsl:param name="fullName" /> 
  <xsl:variable name="articles" select="tokenize($list,';')" />
  <xsl:for-each select="$articles">
     <xsl:variable name = "articleID"><xsl:value-of select="position()" /></xsl:variable>
     <xsl:variable name = "article" select="."/> 
     <xsl:variable name="articleParts" select="tokenize($article,';')" />
     <xsl:for-each select="$articleParts">
     </xsl:for-each>
     <!-- authorship -->
	 <rdf:Description rdf:about="{$baseURI}authorship/caupub-article{$articleID}-person{$localPersonID}">
	   <localVivo:harvestedBy>CAU Harvester</localVivo:harvestedBy>
		<rdf:type rdf:resource="http://vivoweb.org/ontology/core#Authorship" />
		<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#Authorship" />
		<rdf:type rdf:resource="http://vivoweb.org/ontology/core#Relationship" />
		<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
		<rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000020" />
		<rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000001" />
		<rdf:type rdf:resource="http://purl.obolibrary.org/obo/BFO_0000002" />
		 
		<xsl:if test="normalize-space($fullName)">
			<rdfs:label>Authorship for <xsl:value-of select = "$fullName" /></rdfs:label>
		</xsl:if>
		 
		<vivo:relates rdf:resource="{$baseURI}person/person{$localPersonID}" />
		<vivo:relates rdf:resource="{$baseURI}caupub/caupub-article{$articleID}-person{$localPersonID}" /> 
		<vivo:authorRank rdf:datatype="http://www.w3.org/2001/XMLSchema#int">1</vivo:authorRank>
	</rdf:Description>
  </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="articlesFull"
    xmlns:parseArticle = "java:edu.cornell.mannlib.harvester.xslt.ParseArticle"
    extension-element-prefixes = "parseArticle"
  >
  <xsl:param name='list' />
  <xsl:param name="localPersonID" /> 
  <xsl:variable name="articles" select="tokenize($list,';')" />
  <xsl:for-each select="$articles">
     <xsl:variable name = "article" select="."/>
     <xsl:variable name = "articleID"><xsl:value-of select="position()" /></xsl:variable>
     <xsl:variable name = "articleTitle"><xsl:value-of select="parseArticle:getTitle($article)" /></xsl:variable>
     <xsl:variable name = "journalTitle"><xsl:value-of select="parseArticle:getJournalTitle($article)" /></xsl:variable>
     <xsl:variable name = "articleYear"><xsl:value-of select="parseArticle:getArticleYear($article)" /></xsl:variable>
     <rdf:Description rdf:about="{$baseURI}caupub/caupub-article{$articleID}-person{$localPersonID}">
     <localVivo:article><xsl:value-of select="$article"/></localVivo:article>
     <localVivo:articleTitle><xsl:value-of select="$articleTitle"/></localVivo:articleTitle>
     <localVivo:journalTitle><xsl:value-of select="$journalTitle"/></localVivo:journalTitle>
     <localVivo:articleYear><xsl:value-of select="$articleYear"/></localVivo:articleYear>
     
     
     <rdf:type rdf:resource="http://purl.org/ontology/bibo/Article" />
     <rdf:type rdf:resource="http://purl.org/ontology/bibo/Document" />
     <rdfs:label><xsl:value-of select="$articleTitle" /></rdfs:label>
     <vivo:dateTimeValue rdf:resource="{$baseURI}dateTime/dateTime{$articleYear}" /> 
     </rdf:Description>
     
     <xsl:call-template name="articleYear">
        <xsl:with-param name="year" select="$articleYear"/>
     </xsl:call-template>
     
     
  </xsl:for-each>
  
  
  </xsl:template>
  
  <xsl:template name="articleYear">
     <xsl:param name="year" />
     
     <rdf:Description rdf:about="{$baseURI}dateTime/dateTime{$year}">
     <rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
     <vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
     <vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="$year" />-01-01T00:00:00</vivo:dateTime>
     </rdf:Description> 
  </xsl:template>
  
  <!--   <vivo:relatedBy rdf:resource="{$baseURI}authorship/pub{$pubNum}" /> -->
  
  <xsl:template name="articles">
     <xsl:param name='list' />
     <xsl:if test="contains($list, ';')">          
         <!--  <localVivo:article><xsl:value-of select="substring-before($list, ';')"/></localVivo:article> -->         
         <xsl:call-template name="articles">
            <xsl:with-param name="list" select="substring-after($list, ';')"/>
        </xsl:call-template>
     </xsl:if>        
  </xsl:template>
  
  
   
  
</xsl:stylesheet>
