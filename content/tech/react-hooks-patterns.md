---
title: "React Hooksの実践的なパターンとカスタムフック"
date: 2024-02-05T11:20:00Z
draft: false
categories: ["tech"]
tags: ["react", "hooks", "frontend"]
author: "Tech Writer"
---

# React Hooksの実践的なパターンとカスタムフック

React Hooksは、関数コンポーネントでstateやライフサイクルメソッドを使用できるようにする機能です。この記事では、実践的なパターンとカスタムフックの作成方法を説明します。

## 基本的なHooks

### 1. useState

```jsx
import React, { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>
        Increment
      </button>
    </div>
  );
}
```

### 2. useEffect

```jsx
import React, { useState, useEffect } from 'react';

function DataFetcher() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch('/api/data');
        const result = await response.json();
        setData(result);
      } catch (error) {
        console.error('Error fetching data:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) return <div>Loading...</div>;
  return <div>{JSON.stringify(data)}</div>;
}
```

## カスタムフックの作成

### 1. データフェッチング用のカスタムフック

```jsx
import { useState, useEffect } from 'react';

function useApi(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const response = await fetch(url);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const result = await response.json();
        setData(result);
        setError(null);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [url]);

  return { data, loading, error };
}

// 使用例
function UserProfile({ userId }) {
  const { data: user, loading, error } = useApi(`/api/users/${userId}`);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  return <div>{user?.name}</div>;
}
```

### 2. ローカルストレージ用のカスタムフック

```jsx
import { useState, useEffect } from 'react';

function useLocalStorage(key, initialValue) {
  const [storedValue, setStoredValue] = useState(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      console.error(`Error reading localStorage key "${key}":`, error);
      return initialValue;
    }
  });

  const setValue = (value) => {
    try {
      setStoredValue(value);
      window.localStorage.setItem(key, JSON.stringify(value));
    } catch (error) {
      console.error(`Error setting localStorage key "${key}":`, error);
    }
  };

  return [storedValue, setValue];
}

// 使用例
function ThemeToggle() {
  const [theme, setTheme] = useLocalStorage('theme', 'light');

  const toggleTheme = () => {
    setTheme(theme === 'light' ? 'dark' : 'light');
  };

  return (
    <button onClick={toggleTheme}>
      Current theme: {theme}
    </button>
  );
}
```

## 実践的なパターン

### 1. 依存関係の配列の最適化

```jsx
// 悪い例
useEffect(() => {
  fetchData(userId, filters);
}, [userId, filters]); // filtersが毎回新しいオブジェクトの場合

// 良い例
const memoizedFilters = useMemo(() => filters, [filters.status, filters.category]);
useEffect(() => {
  fetchData(userId, memoizedFilters);
}, [userId, memoizedFilters]);
```

### 2. クリーンアップの適切な処理

```jsx
useEffect(() => {
  const timer = setInterval(() => {
    console.log('Timer tick');
  }, 1000);

  return () => {
    clearInterval(timer);
  };
}, []);
```

## まとめ

React Hooksは、コンポーネントのロジックを再利用可能でテストしやすい形で整理するのに役立ちます。カスタムフックを活用することで、より保守しやすいコードを書くことができます。
