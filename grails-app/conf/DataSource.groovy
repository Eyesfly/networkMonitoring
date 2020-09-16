dataSource {
    pooled = true
    jmxExport = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
//    cache.region.factory_class = 'org.hibernate.cache.SingletonEhCacheRegionFactory' // Hibernate 3
    cache.region.factory_class = 'org.hibernate.cache.ehcache.SingletonEhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
    flush.mode = 'manual' // OSIV session flush mode outside of transactional context
}

// environment specific settings
environments {
    development {
        dataSource {
           /* dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"*/
            dbCreate = "update"
            driverClassName="com.mysql.jdbc.Driver"
            url = "jdbc:mysql://127.0.0.1:3306/netMonitor?useCursorFetch=true"
            username = "root"
            password = "root123"
            dialect = "org.hibernate.dialect.MySQLDialect"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            driverClassName="com.mysql.jdbc.Driver"
            url = "jdbc:mysql://127.0.0.1:3306/netMonitor?useCursorFetch=true"
            username = "root"
            password = "ippr_EVCC@123"
            dialect = "org.hibernate.dialect.MySQLDialect"
            properties {
                validationQuery = "SELECT 1"
                validationQueryTimeout = 3
                validationInterval = 15000
                testOnBorrow = true
                testWhileIdle = true
            }
        }
    }
}
