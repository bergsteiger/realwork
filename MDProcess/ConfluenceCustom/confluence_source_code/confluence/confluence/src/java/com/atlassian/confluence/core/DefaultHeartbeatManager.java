package com.atlassian.confluence.core;

import com.atlassian.cache.Cache;
import com.atlassian.cache.CacheFactory;
import com.atlassian.confluence.concurrent.Lock;
import com.atlassian.confluence.concurrent.LockFactory;
import com.atlassian.confluence.concurrent.LockOperationWithoutResult;
import com.atlassian.confluence.user.UserAccessor;
import com.atlassian.spring.container.ContainerManager;
import com.atlassian.user.User;

import java.io.ObjectStreamException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

public class DefaultHeartbeatManager implements HeartbeatManager
{
    public static final long TIMEOUT_MS = 30000;
    private static final String ACTIVITY_CACHE_NAME = "com.atlassian.confluence.core.DefaultHeartbeatManager.activities";

    private static class Activity implements Serializable
    {
        public Date getDate()
        {
            return date;
        }

        public User getUser()
        {
            return user;
        }

        public Object getKey()
        {
            return key;
        }

        private Date date;
        private transient User user; // User objects are not expected to be serializable
        private String userName;
        private Object key;

        public Activity(Object key, User user)
        {
            this.date = new Date();
            this.user = user;
            this.userName = user.getName();
            this.key = key;
        }

        public boolean equals(Object o)
        {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;

            final Activity activity = (Activity) o;

            if (!key.equals(activity.key)) return false;
            if (!user.equals(activity.user)) return false;

            return true;
        }

        public int hashCode()
        {
            int result;
            result = user.hashCode();
            result = 29 * result + key.hashCode();
            return result;
        }

        private Object readResolve() throws ObjectStreamException
        {
            // Reinstantiate the user object based on the user name
            UserAccessor userAccessor = (UserAccessor) ContainerManager.getComponent("userAccessor");
            this.user = userAccessor.getUser(this.userName);
            return this;
        }
    }

    private Cache activities;
    private CacheFactory cacheFactory;
    private LockFactory lockFactory;

    public long getHeartbeatInterval()
    {
        return TIMEOUT_MS;
    }

    public List/*<User>*/ getUsersForActivity(final Object key)
    {
        final List userList = new ArrayList();
        new GetUsersForActivityOperation(getActivityLock(key), key, userList).run();
        return userList;
    }

    private Lock getActivityLock(Object key)
    {
        return lockFactory.getLock(ACTIVITY_CACHE_NAME + "." + key.toString());
    }

    public void startActivity(final Object key, final User user)
    {
        if (user == null)
            return;

        new StartActivityOperation(getActivityLock(key), key, user).run();
    }

    public void stopActivity(final Object key, final User user)
    {
        if (user == null)
            return;

        new StopActivityOperation(getActivityLock(key), key, user).run();
    }

    public void init()
    {
        activities = cacheFactory.getCache(ACTIVITY_CACHE_NAME);
    }

    public void setCacheFactory(CacheFactory cacheFactory)
    {
        this.cacheFactory = cacheFactory;
    }

    public void setLockFactory(LockFactory lockFactory)
    {
        this.lockFactory = lockFactory;
    }

    private class StartActivityOperation extends LockOperationWithoutResult
    {
        private final Object key;
        private final User user;

        public StartActivityOperation(Lock lock, Object key, User user)
        {
            super(lock);
            this.key = key;
            this.user = user;
        }

        protected void withLockNoResult()
        {
            Set s = (Set) activities.get(key);
            if (s == null)
            {
                s = new HashSet();
            }
            Activity a = new Activity(key, user);
            s.remove(a);
            s.add(a);
            activities.put(key, s); // Make the cache aware of the changed set
        }
    }

    private class StopActivityOperation extends LockOperationWithoutResult
    {
        private final Object key;
        private final User user;

        public StopActivityOperation(Lock lock, Object key, User user)
        {
            super(lock);
            this.key = key;
            this.user = user;
        }

        protected void withLockNoResult()
        {
            Set s = (Set) activities.get(key);
            if (s != null)
            {
                s.remove(new Activity(key, user));
                activities.put(key, s); // Make the cache aware of the changed set
            }
        }
    }

    private class GetUsersForActivityOperation extends LockOperationWithoutResult
    {
        private final Object key;
        private final List l;

        public GetUsersForActivityOperation(Lock lock, Object key, List l)
        {
            super(lock);
            this.key = key;
            this.l = l;
        }

        protected void withLockNoResult()
        {
            Set s = (Set) activities.get(key);
            if (s == null)
                return;

            long currentTime = System.currentTimeMillis();
            for (Iterator iterator = s.iterator(); iterator.hasNext();)
            {
                Activity activity = (Activity) iterator.next();
                if (currentTime - activity.getDate().getTime() > 2 * TIMEOUT_MS)
                {
                    iterator.remove();
                } else
                {
                    l.add(activity.getUser());
                }
            }
            activities.put(key, s); // Make the cache aware of the changed set
        }
    }
}
